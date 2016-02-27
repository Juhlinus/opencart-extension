<?php if (!isset($redirect)) { 
?>
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
        </div>
        <div class="panel panel-default">
          <div class="panel-heading" id="personal">
            <h4 class="panel-title"><b id="personal-button">Genomför Order</b></h4>
          </div>
          <div class="panel-body" style="margin-left: 15px;">
              <h3><u>Make sure your order is correct.</u></h3>
              <br />
              <h4><?=$misc['payment_firstname'];?> <?=$misc['payment_lastname'];?></h4>
              <h4><?=$misc['payment_address_1'];?></h4>
              <h4><?=$misc['payment_postcode'];?> <?=$misc['payment_city'];?></h4>
          </div>
          <div class="panel-body">
            <?=$payment;?>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<?php
} else { ?>
<script type="text/javascript"><!--
  location = '<?php echo $redirect; ?>';
//--></script>
<?php } ?>
