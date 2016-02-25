<?php
class ControllerKassaKundvagn extends Controller 
{
	public function index()
	{
		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_error'] = $this->language->get('text_empty');

		$data['button_continue'] = $this->language->get('button_continue');

		$data['continue'] = $this->url->link('common/home');

		unset($this->session->data['success']);

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/error/not_found.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/error/not_found.tpl', $data));
		}
	}
}