<?=$header;?>
<div class="container">
	<div class="row">
		<?php echo $column_left; ?>
		<?php if ($column_left && $column_right) { ?>
		<?php $class = 'col-sm-6'; ?>
		<?php } elseif ($column_left || $column_right) { ?>
		<?php $class = 'col-sm-9'; ?>
		<?php } else { ?>
		<?php $class = 'col-sm-12'; ?>
		<?php } ?>
		<div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
			<h1><?=$heading_title;?></h1>
			<div class="panel-group" id="accordion">
				<div class="panel panel-default">
					<table class="table table-bordered table-hover">
						<thead>
							<tr>
								<td class="text-left"><?php echo $column_name; ?></td>
								<td class="text-left"><?php echo $column_model; ?></td>
								<td class="text-right"><?php echo $column_quantity; ?></td>
								<td class="text-right"><?php echo $column_price; ?></td>
								<td class="text-right"><?php echo $column_total; ?></td>
							</tr>
						</thead>
						<tbody>
							<?php foreach ($products as $product) { ?>
							<tr>
								<td class="text-left"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
									<?php foreach ($product['option'] as $option) { ?>
									<br />
									&nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
									<?php } ?>
									<?php if($product['recurring']) { ?>
									<br />
									<span class="label label-info"><?php echo $text_recurring_item; ?></span> <small><?php echo $product['recurring']; ?></small>
									<?php } ?></td>
									<td class="text-left"><?php echo $product['model']; ?></td>
									<td class="text-right"><?php echo $product['quantity']; ?></td>
									<td class="text-right"><?php echo $product['price']; ?></td>
									<td class="text-right"><?php echo $product['total']; ?></td>
								</tr>
								<?php } ?>
					      <!--
					      <?php foreach ($vouchers as $voucher) { ?>
					      <tr>
					        <td class="text-left"><?php echo $voucher['description']; ?></td>
					        <td class="text-left"></td>
					        <td class="text-right">1</td>
					        <td class="text-right"><?php echo $voucher['amount']; ?></td>
					        <td class="text-right"><?php echo $voucher['amount']; ?></td>
					      </tr>
					      <?php } ?>
					  -->
					</tbody>
					<tfoot>
						<?php foreach ($totals as $total) { ?>
						<tr>
							<td colspan="4" class="text-right"><strong><?php echo $total['title']; ?>:</strong></td>
							<td class="text-right"><?php echo $total['text']; ?></td>
						</tr>
						<?php } ?>
					</tfoot>
				</table>
				<br />
			</div>
			<div class="panel panel-default">

				<div class="panel-heading" id="personal">
					<h4 class="panel-title"><b id="personal-button">Genomför Order</b></h4>
				</div>
				<div class="panel-body">
					<div id="payment-new" style="display: <?php echo ($addresses ? 'none' : 'block'); ?>;">
						<form action="index.php?route=kassa/kassa/submit" method="post">
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="input-payment-firstname"><?php echo $entry_firstname; ?></label>
								<div class="col-sm-10">
									<input type="text" name="firstname" value="" placeholder="<?php echo $entry_firstname; ?>" id="input-payment-firstname" class="form-control" />
								</div>
							</div>
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="input-payment-lastname"><?php echo $entry_lastname; ?></label>
								<div class="col-sm-10">
									<input type="text" name="lastname" value="" placeholder="<?php echo $entry_lastname; ?>" id="input-payment-lastname" class="form-control" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-payment-company"><?php echo $entry_company; ?></label>
								<div class="col-sm-10">
									<input type="text" name="company" value="" placeholder="<?php echo $entry_company; ?>" id="input-payment-company" class="form-control" />
								</div>
							</div>
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="input-payment-address-1"><?php echo $entry_address_1; ?></label>
								<div class="col-sm-10">
									<input type="text" name="address_1" value="" placeholder="<?php echo $entry_address_1; ?>" id="input-payment-address-1" class="form-control" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="input-payment-address-2"><?php echo $entry_address_2; ?></label>
								<div class="col-sm-10">
									<input type="text" name="address_2" value="" placeholder="<?php echo $entry_address_2; ?>" id="input-payment-address-2" class="form-control" />
								</div>
							</div>
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="input-payment-city"><?php echo $entry_city; ?></label>
								<div class="col-sm-10">
									<input type="text" name="city" value="" placeholder="<?php echo $entry_city; ?>" id="input-payment-city" class="form-control" />
								</div>
							</div>
							<div class="form-group required">
								<label class="col-sm-2 control-label" for="input-payment-postcode"><?php echo $entry_postcode; ?></label>
								<div class="col-sm-10">
									<input type="text" name="postcode" value="" placeholder="<?php echo $entry_postcode; ?>" id="input-payment-postcode" class="form-control" />
								</div>
							</div>
						<!--
						<div class="form-group required">
							<label class="col-sm-2 control-label" for="input-payment-country"><?php echo $entry_country; ?></label>
							<div class="col-sm-10">
								<select name="country_id" id="input-payment-country" class="form-control">
									<option value=""><?php echo $text_select; ?></option>
									<?php foreach ($countries as $country) { ?>
									<?php if ($country['country_id'] == $country_id) { ?>
									<option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
									<?php } else { ?>
									<option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
									<?php } ?>
									<?php } ?>
								</select>
							</div>
						</div>
						<div class="form-group required">
							<label class="col-sm-2 control-label" for="input-payment-zone"><?php echo $entry_zone; ?></label>
							<div class="col-sm-10">
								<select name="zone_id" id="input-payment-zone" class="form-control">
								</select>
							</div>
						</div>
					-->
					<input type="hidden" name="country_id" value="203" />
					<input type="hidden" name="zone_id" value="0" />
					<input type="hidden" name="zone" value="0" />
					<!-- <input type="hidden" name="shipping_methods[]" value='<?=json_encode($shipping_methods);?>' /> -->
					<!-- <input type="hidden" name="shipping_methods[]" value='<?= implode(",", $shipping_methods["weight"]["quote"]["weight_5"]);?>' /> -->
					<input type="hidden" name="shipping_methods[]" value='<?= implode(",", $shipping_methods["weight"]["quote"]["weight_5"]); ?>' />
					<input type="hidden" name="totalWeight" value="<?=$totalWeight;?>" />
					<?php
					if ($payment_methods) { ?>
					<p><?php echo $text_payment_method; ?></p>
					<?php foreach ($payment_methods as $payment_method) { ?>
					<div class="radio">
						<label>
							<?php if ($payment_method['code'] == $code || !$code) { ?>
							<?php $code = $payment_method['code']; ?>
							<input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" checked="checked" />
							<?php } else { ?>
							<input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" />
							<?php } ?>
							<?php echo $payment_method['title']; ?>
							<input type="hidden" name="payment_title" value="<?=$payment_method['title'];?>" />
							<?php if ($payment_method['terms']) { ?>
							(<?php echo $payment_method['terms']; ?>)
							<?php } ?>
						</label>
					</div>
					<?php } ?>
					<?php } ?>
					<input type="submit" name="submit" value="submit" />
				</form>
			</div>
		</div>
	</div>
</div>
</div>
</div>