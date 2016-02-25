<?php
// Visa weight kostnad
class ControllerKassaKassa extends Controller
{
	public function index()
	{
		if ((!$this->cart->hasProducts() && empty($this->session->data['vouchers'])) || 
			(!$this->cart->hasStock() && !$this->config->get('config_stock_checkout'))) 
			$this->response->redirect($this->url->link('kassa/kundvagn'));

		$this->load->language('checkout/checkout');

		$data['text_address_existing'] = $this->language->get('text_address_existing');
		$data['text_address_new'] = $this->language->get('text_address_new');
		$data['text_select'] = $this->language->get('text_select');
		$data['text_none'] = $this->language->get('text_none');
		$data['text_loading'] = $this->language->get('text_loading');

		$data['entry_firstname'] = $this->language->get('entry_firstname');
		$data['entry_lastname'] = $this->language->get('entry_lastname');
		$data['entry_company'] = $this->language->get('entry_company');
		$data['entry_address_1'] = $this->language->get('entry_address_1');
		$data['entry_address_2'] = $this->language->get('entry_address_2');
		$data['entry_postcode'] = $this->language->get('entry_postcode');
		$data['entry_city'] = $this->language->get('entry_city');
		$data['entry_country'] = $this->language->get('entry_country');
		$data['entry_zone'] = $this->language->get('entry_zone');

		$data['button_continue'] = $this->language->get('button_continue');
		$data['button_upload'] = $this->language->get('button_upload');

		/* Products */
		$products = $this->cart->getProducts();

		foreach ($products as $product) {
			$product_total = 0;

			foreach ($products as $product_2) {
				if ($product_2['product_id'] == $product['product_id']) {
					$product_total += $product_2['quantity'];
				}
			}

			if ($product['minimum'] > $product_total) {
				$this->response->redirect($this->url->link('kassa/cart'));
			}
		}

		foreach ($products as $key => $value)			
			$products[$key]['tax'] = $this->tax->getTax($product['price'], $product['tax_class_id']);

		// Always Sweden
		$this->session->data['payment_address']['country_id'] = 203;
		$this->session->data['payment_address']['zone_id'] = '';

		$data['text_payment_method'] = $this->language->get('text_payment_method');

		/* Payment Options */
		$total_data = array();
		$total = 0;
		$taxes = $this->cart->getTaxes();

		$this->load->model('extension/extension');

		$sort_order = array();

		$results = $this->model_extension_extension->getExtensions('total');

		foreach ($results as $key => $value) {
			$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
		}

		array_multisort($sort_order, SORT_ASC, $results);

		foreach ($results as $result) {
			if ($this->config->get($result['code'] . '_status')) {
				$this->load->model('total/' . $result['code']);

				$this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
			}
		}

		$method_data = array();

		$this->load->model('extension/extension');

		$results = $this->model_extension_extension->getExtensions('payment');

		$recurring = $this->cart->hasRecurringProducts();

		foreach ($results as $result) {
			if ($this->config->get($result['code'] . '_status')) {
				$this->load->model('payment/' . $result['code']);

				$method = $this->{'model_payment_' . $result['code']}->getMethod($this->session->data['payment_address'], $total);

				if ($method) {
					if ($recurring) {
						if (method_exists($this->{'model_payment_' . $result['code']}, 'recurringPayments') && $this->{'model_payment_' . $result['code']}->recurringPayments()) {
							$method_data[$result['code']] = $method;
						}
					} else {
						$method_data[$result['code']] = $method;
					}
				}
			}
		}

		$sort_order = array();

		foreach ($method_data as $key => $value) {
			$sort_order[$key] = $value['sort_order'];
		}

		array_multisort($sort_order, SORT_ASC, $method_data);

		//$this->session->data['payment_methods'] = $method_data;
		$data['payment_methods'] = $method_data;

		/* Shipping Methods */
		if (isset($this->session->data['payment_address'])) {
			// Shipping Methods
			$method_data = array();

			$this->load->model('extension/extension');

			$results = $this->model_extension_extension->getExtensions('shipping');

			foreach ($results as $result) {
				if ($this->config->get($result['code'] . '_status')) {
					$this->load->model('shipping/' . $result['code']);

					$quote = $this->{'model_shipping_' . $result['code']}->getQuote($this->session->data['payment_address']);

					if ($quote) {
						$method_data[$result['code']] = array(
							'title'      => $quote['title'],
							'quote'      => $quote['quote'],
							'sort_order' => $quote['sort_order'],
							'error'      => $quote['error']
							);
					}
				}
			}

			$sort_order = array();

			foreach ($method_data as $key => $value) {
				$sort_order[$key] = $value['sort_order'];
			}

			array_multisort($sort_order, SORT_ASC, $method_data);

			//$this->session->data['shipping_methods'] = $method_data;
			$data['shipping_methods'] = $method_data;
		}

		/**
		 *	Misc
		 */

		$this->load->language('checkout/checkout');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/moment.js');
		$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js');
		$this->document->addStyle('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css');

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
			);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_cart'),
			'href' => $this->url->link('kassa/cart')
			);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('kassa/checkout', '', 'SSL')
			);

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_checkout_option'] = $this->language->get('text_checkout_option');
		$data['text_checkout_account'] = $this->language->get('text_checkout_account');
		$data['text_checkout_payment_address'] = $this->language->get('text_checkout_payment_address');
		$data['text_checkout_shipping_address'] = $this->language->get('text_checkout_shipping_address');
		$data['text_checkout_shipping_method'] = $this->language->get('text_checkout_shipping_method');
		$data['text_checkout_payment_method'] = $this->language->get('text_checkout_payment_method');
		$data['text_checkout_confirm'] = $this->language->get('text_checkout_confirm');

		if (isset($this->session->data['error'])) {
			$data['error_warning'] = $this->session->data['error'];
			unset($this->session->data['error']);
		} else {
			$data['error_warning'] = '';
		}

		$data['logged'] = $this->customer->isLogged();

		if (isset($this->session->data['account'])) {
			$data['account'] = $this->session->data['account'];
		} else {
			$data['account'] = '';
		}

		$data['shipping_required'] = $this->cart->hasShipping();

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
		$data['code'] = 203;

		$data['products'] = $products;

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/kassa/kassa.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/kassa/kassa.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/kassa/kassa.tpl', $data));
		}
	}

	public function submit()
	{
		$redirect = '';

		if ($this->cart->hasShipping())
		{
			if (!isset($this->request->post['address_1']))
				$redirect = $this->url->link('kassa/kassa', '', 'SSL');
		}

		//print_r($this->request->post);

		if (!$redirect)
		{
			$order_data = array();

			$order_data['totals'] = array();
			$total = 0;
			$taxes = $this->cart->getTaxes();

			$this->load->model('extension/extension');

			$sort_order = array();

			$results = $this->model_extension_extension->getExtensions('total');

			foreach ($results as $key => $value)
				$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');

			array_multisort($sort_order, SORT_ASC, $results);

			foreach ($results as $result) {
				if ($this->config->get($result['code'] . '_status')) {
					$this->load->model('total/' . $result['code']);

					$this->{'model_total_' . $result['code']}->getTotal($order_data['totals'], $total, $taxes);
				}
			}

			$sort_order = array();

			foreach ($order_data['totals'] as $key => $value)
				$sort_order[$key] = $value['sort_order'];

			array_multisort($sort_order, SORT_ASC, $order_data['totals']);

			$this->load->language('checkout/checkout');

			$order_data['invoice_prefix'] = $this->config->get('config_invoice_prefix');
			$order_data['store_id'] = $this->config->get('config_store_id');
			$order_data['store_name'] = $this->config->get('config_name');

			if ($order_data['store_id'])
				$order_data['store_url'] = $this->config->get('config_url');
			else
				$order_data['store_url'] = HTTP_SERVER;

			$shipping_method = explode(',', $this->request->post['shipping_methods'][0]);

			$order_data['customer_id'] = 0;
			$order_data['customer_group_id'] = 0;

			$order_data['firstname'] = $this->request->post['firstname'];
			$order_data['lastname'] = $this->request->post['lastname'];
			// FIXA MAIL
			$order_data['email'] = ($this->request->post['email'] = '');
			$order_data['telephone'] = ($this->request->post['telephone'] = '');
			$order_data['fax'] = '';

			$order_data['payment_firstname'] = $this->request->post['firstname'];
			$order_data['payment_lastname'] = $this->request->post['lastname'];
			$order_data['payment_company'] = $this->request->post['company'];
			$order_data['payment_address_1'] = $this->request->post['address_1'];
			$order_data['payment_address_2'] = $this->request->post['address_2'];
			$order_data['payment_city'] = $this->request->post['city'];
			$order_data['payment_postcode'] = $this->request->post['postcode'];
			$order_data['payment_zone'] = $this->request->post['zone'];
			$order_data['payment_zone_id'] = $this->request->post['zone_id'];
			$order_data['payment_country'] = ($this->request->post['country'] = 'Sweden');
			$order_data['payment_country_id'] = $this->request->post['country_id'];
			$order_data['payment_method'] = $this->request->post['payment_method'];
			$order_data['payment_code'] = $this->request->post['payment_method'];
			// Fix this
			$order_data['payment_address_format'] = nl2br('{company}
			{firstname} {lastname}
			{address_1}
			{address_2}
			{postcode} {city}
			{country}');

			$order_data['shipping_firstname'] = $this->request->post['firstname'];
			$order_data['shipping_lastname'] = $this->request->post['lastname'];
			$order_data['shipping_company'] = $this->request->post['company'];
			$order_data['shipping_address_1'] = $this->request->post['address_1'];
			$order_data['shipping_address_2'] = $this->request->post['address_2'];
			$order_data['shipping_city'] = $this->request->post['city'];
			$order_data['shipping_postcode'] = $this->request->post['postcode'];
			$order_data['shipping_zone'] = $this->request->post['zone'];
			$order_data['shipping_zone_id'] = $this->request->post['zone_id'];
			$order_data['shipping_country'] = ($this->request->post['country'] = 'Sweden');
			$order_data['shipping_country_id'] = $this->request->post['country_id'];

			$order_data['shipping_code'] = $shipping_method[0];
			$order_data['shipping_method'] = $shipping_method[1];

			$order_data['shipping_address_format'] = '';

			$order_data['comment'] = '';
			$order_data['affiliate_id'] = '';
			$order_data['commission'] = '';
			$order_data['tracking'] = '';
			$order_data['marketing_id'] = '';

			/* Products */
			$order_data['products'] = array();

			foreach ($this->cart->getProducts() as $product) {
				$option_data = array();

				foreach ($product['option'] as $option) {
					$option_data[] = array(
						'product_option_id'       => $option['product_option_id'],
						'product_option_value_id' => $option['product_option_value_id'],
						'option_id'               => $option['option_id'],
						'option_value_id'         => $option['option_value_id'],
						'name'                    => $option['name'],
						'value'                   => $option['value'],
						'type'                    => $option['type']
						);
				}

				$order_data['products'][] = array(
					'product_id' => $product['product_id'],
					'name'       => $product['name'],
					'model'      => $product['model'],
					'option'     => $option_data,
					'download'   => $product['download'],
					'quantity'   => $product['quantity'],
					'subtract'   => $product['subtract'],
					'price'      => $product['price'],
					'total'      => $product['total'],
					'tax'        => $this->tax->getTax($product['price'], $product['tax_class_id']),
					'reward'     => $product['reward']
					);
			}

			/* Vouchers */
			$order_data['vouchers'] = array();

			if (!empty($this->session->data['vouchers'])) {
				foreach ($this->session->data['vouchers'] as $voucher) {
					$order_data['vouchers'][] = array(
						'description'      => $voucher['description'],
						'code'             => token(10),
						'to_name'          => $voucher['to_name'],
						'to_email'         => $voucher['to_email'],
						'from_name'        => $voucher['from_name'],
						'from_email'       => $voucher['from_email'],
						'voucher_theme_id' => $voucher['voucher_theme_id'],
						'message'          => $voucher['message'],
						'amount'           => $voucher['amount']
						);
				}
			}

			$order_data['total'] = $total + $this->request->post['totalWeight'];

			$order_data['language_id'] = $this->config->get('config_language_id');
			$order_data['currency_id'] = $this->currency->getId();
			$order_data['currency_code'] = $this->currency->getCode();
			$order_data['currency_value'] = $this->currency->getValue($this->currency->getCode());
			$order_data['ip'] = $this->request->server['REMOTE_ADDR'];

			if (!empty($this->request->server['HTTP_X_FORWARDED_FOR']))
				$order_data['forwarded_ip'] = $this->request->server['HTTP_X_FORWARDED_FOR'];
			elseif (!empty($this->request->server['HTTP_CLIENT_IP']))
				$order_data['forwarded_ip'] = $this->request->server['HTTP_CLIENT_IP'];
			else
				$order_data['forwarded_ip'] = '';


			if (isset($this->request->server['HTTP_USER_AGENT']))
				$order_data['user_agent'] = $this->request->server['HTTP_USER_AGENT'];
			else
				$order_data['user_agent'] = '';


			if (isset($this->request->server['HTTP_ACCEPT_LANGUAGE']))
				$order_data['accept_language'] = $this->request->server['HTTP_ACCEPT_LANGUAGE'];
			else
				$order_data['accept_language'] = '';

			$this->load->model('checkout/order');

			$this->session->data['order_id'] = $this->model_checkout_order->addOrder($order_data);

			$data['text_recurring_item'] = $this->language->get('text_recurring_item');
			$data['text_payment_recurring'] = $this->language->get('text_payment_recurring');

			$data['column_name'] = $this->language->get('column_name');
			$data['column_model'] = $this->language->get('column_model');
			$data['column_quantity'] = $this->language->get('column_quantity');
			$data['column_price'] = $this->language->get('column_price');
			$data['column_total'] = $this->language->get('column_total');

			$this->load->model('tool/upload');

			$data['products'] = array();

			foreach ($this->cart->getProducts() as $product) {
				$option_data = array();

				foreach ($product['option'] as $option) {
					if ($option['type'] != 'file') {
						$value = $option['value'];
					} else {
						$upload_info = $this->model_tool_upload->getUploadByCode($option['value']);

						if ($upload_info) {
							$value = $upload_info['name'];
						} else {
							$value = '';
						}
					}

					$option_data[] = array(
						'name'  => $option['name'],
						'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value)
						);
				}

				$recurring = '';

				if ($product['recurring']) {
					$frequencies = array(
						'day'        => $this->language->get('text_day'),
						'week'       => $this->language->get('text_week'),
						'semi_month' => $this->language->get('text_semi_month'),
						'month'      => $this->language->get('text_month'),
						'year'       => $this->language->get('text_year'),
						);

					if ($product['recurring']['trial']) {
						$recurring = sprintf($this->language->get('text_trial_description'), $this->currency->format($this->tax->calculate($product['recurring']['trial_price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax'))), $product['recurring']['trial_cycle'], $frequencies[$product['recurring']['trial_frequency']], $product['recurring']['trial_duration']) . ' ';
					}

					if ($product['recurring']['duration']) {
						$recurring .= sprintf($this->language->get('text_payment_description'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax'))), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
					} else {
						$recurring .= sprintf($this->language->get('text_payment_cancel'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax'))), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
					}
				}

				$data['products'][] = array(
					'cart_id'    => $product['cart_id'],
					'product_id' => $product['product_id'],
					'name'       => $product['name'],
					'model'      => $product['model'],
					'option'     => $option_data,
					'recurring'  => $recurring,
					'quantity'   => $product['quantity'],
					'subtract'   => $product['subtract'],
					'price'      => $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax'))),
					'total'      => $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')) * $product['quantity']),
					'href'       => $this->url->link('product/product', 'product_id=' . $product['product_id']),
					);
			}
			// Gift Voucher
			$data['vouchers'] = array();

			if (!empty($this->session->data['vouchers'])) {
				foreach ($this->session->data['vouchers'] as $voucher) {
					$data['vouchers'][] = array(
						'description' => $voucher['description'],
						'amount'      => $this->currency->format($voucher['amount'])
						);
				}
			}

			$data['totals'] = array();

			// Här
			foreach ($order_data['totals'] as $total) {
				$data['totals'][] = array(
					'title' => $total['title'],
					'text'  => $this->currency->format($total['value']),
					);
			}
			$data['payment'] = $this->load->controller('payment/' . $order_data['payment_code']);
		}
		else
			$data['redirect'] = $redirect;

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/confirm.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/checkout/confirm.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/checkout/confirm.tpl', $data));
		}
	}
}