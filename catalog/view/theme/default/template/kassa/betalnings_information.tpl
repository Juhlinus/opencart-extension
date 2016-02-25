<form class="form-horizontal">
  <p>Vill du hämta din adress med hjälp av personnummer, <a href="index.php?route=kassa/kassa">klicka här</a>.</p>
  <?php if ($addresses) { ?>
  <div class="radio">
    <label>
      <input type="radio" name="payment_address" value="existing" checked="checked" />
      <?php echo $text_address_existing; ?></label>
  </div>
  <div id="payment-existing">
    <select name="address_id" class="form-control">
      <?php foreach ($addresses as $address) { ?>
      <?php if ($address['address_id'] == $address_id) { ?>
      <option value="<?php echo $address['address_id']; ?>" selected="selected"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
      <?php } else { ?>
      <option value="<?php echo $address['address_id']; ?>"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
      <?php } ?>
      <?php } ?>
    </select>
  </div>
  <div class="radio">
    <label>
      <input type="radio" name="payment_address" value="new" />
      <?php echo $text_address_new; ?></label>
  </div>
  <?php } ?>
  <br />
  <div id="payment-new" style="display: <?php echo ($addresses ? 'none' : 'block'); ?>;">
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
  </div>
  -->
  <!--
  <div class="buttons clearfix">
    <div class="pull-right">
      <input type="button" value="<?php echo $button_continue; ?>" id="button-payment-address" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary" />
    </div>
  </div>
  -->
</form>