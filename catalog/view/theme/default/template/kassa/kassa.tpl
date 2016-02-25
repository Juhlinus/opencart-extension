<?php echo $header; ?>
<div class="container">
    <div class="row"><?php echo $column_left; ?>
        <?php if ($column_left && $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
        <?php $class = 'col-sm-9'; ?>
        <?php } else { ?>
        <?php $class = 'col-sm-12'; ?>
        <?php } ?>
        <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
            <h1><?php echo $heading_title; ?></h1>
            <div class="panel-group" id="accordion">
                <div class="table-responsive">
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
                                <?php foreach ($vouchers as $voucher) { ?>
                                <tr>
                                    <td class="text-left"><?php echo $voucher['description']; ?></td>
                                    <td class="text-left"></td>
                                    <td class="text-right">1</td>
                                    <td class="text-right"><?php echo $voucher['amount']; ?></td>
                                    <td class="text-right"><?php echo $voucher['amount']; ?></td>
                                </tr>
                                <?php } ?>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="4" class="text-right"><strong><?php echo $totals[1]['title']; ?>:</strong></td>
                                    <td class="text-right"><?php echo $totals[1]['text']; ?></td>
                                </tr>
                            </tfoot>
                        </table>
                        <div class="panel panel-default">
                            <div class="panel-heading col-md-2" id="personal">
                                <h4 class="panel-title"><b id="personal-button">PRIVATPERSON</b></h4>
                            </div>
                            <div class="panel-heading col-md-10" id="corporate">
                                <h4 class="panel-title"><b id="corporate-button">FÖRETAGSKUND</b></h4>
                            </div>
                            <br />
                            <div class="panel-body">
                                <h1>#1 Personuppgifter</h1>
                            </div>
                            <div class="panel-body pers">
                                <b>Personnummer</b>
                                <h1 style="padding-top: 5px; margin-top: 5px;"><input type="text" name="persnr" placeholder="ÅÅMMDD-XXXX" /> <button type="button" class="btn btn-primary">Hämta address</button></h1>
                                <p>Vi hämtar din adress från folkbokföringsregistret. Vill du mata in dina uppgifter manuellt, <a href="#" id="pers-button">klicka här</a>.</p>
                            </div>
                            <div class="panel-body corp">
                                <b>Organisationsnummer</b>
                                <h1 style="padding-top: 5px; margin-top: 5px;"><input type="text" name="orgnr" placeholder="XXXXXX-XXXX" /> <button type="button" class="btn btn-primary">Hämta address</button></h1>
                                <p>Vi hämtar din adress från folkbokföringsregistret. Vill du mata in dina uppgifter manuellt, <a href="#" id="corp-button">klicka här</a>.</p>
                            </div>
                            <div class="panel-body pers-info">
                            </div>
                            <div class="panel-body pay-info">
                                <h1>Betalningsmetod</h1>
                            </div>
                            <div class="panel-body pay-method">
                            </div>
                        </div>
                    </div>
                    <?php echo $content_bottom; ?>
                </div>
                <?php echo $column_right; ?>
            </div>
        </div>
    </div>
<script type="text/javascript"><!--
$(document).ready(function() {
    // Hide/Show Corporate && Personal
    $('.corp').hide();
    $('.pers').show();
    $('#corporate').addClass('hidden-fade');
    $('.pers-info').hide();

    $('#corporate').click(function() {
        $('.corp').show();
        $('.pers').hide();

        $('.pers-info').hide();
        $('#corporate').removeClass('hidden-fade');
        $('#personal').addClass('hidden-fade');
    });

    $('#personal').click(function() {
        $('.corp').hide();
        $('.pers').show();

        $('.pers-info').hide();
        $('#corporate').addClass('hidden-fade');
        $('#personal').removeClass('hidden-fade');
    });

    $('#pers-button,#corp-button').click(function(event) {
        // Prevent redirection
        event.preventDefault();
        
        $('.pers').hide();
        $('.corp').hide();

        $('.pers-info').show();

        $.ajax({
            url: 'index.php?route=kassa/betalnings_information',
            dataType: 'html',
            success: function(html) {
                $('.pers-info').html($('.pers-info').html() + html);
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });
    /* HÄMTA SENARE 
    $.ajax({
            url: 'index.php?route=kassa/betalnings_metod',
            dataType: 'html',
            complete: function() {
                $('#button-shipping-method').button('reset');
            },
            success: function(html) {
                $('.pay-method').html(html);
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
        */
});

$(document).delegate('#button-payment-method', 'click', function() {
    /*
    $.ajax({
        url: 'index.php?route=kassa/confirm',
        dataType: 'html',
        complete: function() {
            $('#button-payment-method').button('reset');
        },
        success: function(html) {
            alert(html);
            
            $('#collapse-checkout-confirm .panel-body').html(html);

            $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<a href="#collapse-checkout-confirm" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_confirm; ?> <i class="fa fa-caret-down"></i></a>');

            $('a[href=\'#collapse-checkout-confirm\']').trigger('click');
            
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
    */
    $.ajax({
        url: 'index.php?route=kassa/betalnings_metod/save',
        type: 'post',
        //data: $('#collapse-payment-method input[type=\'radio\']:checked, #collapse-payment-method input[type=\'checkbox\']:checked, #collapse-payment-method textarea'),
        data: $('input[name=\'address_1\'], input[type=\'checkbox\']:checked, input[type=\'radio\']:checked'),
        dataType: 'json',
        beforeSend: function() {
            $('#button-payment-method').button('loading');
        },
        success: function(json) {
            $('.alert, .text-danger').remove();
            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
                if (json['error']['warning']) {
                    $('body').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }
            } else {
                $.ajax({
                    url: 'index.php?route=kassa/confirm',
                    dataType: 'html',
                    complete: function() {
                        $('#button-payment-method').button('reset');
                    },
                    success: function(html) {
                        //$('#collapse-checkout-confirm .panel-body').html(html);

                        //$('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<a href="#collapse-checkout-confirm" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_confirm; ?> <i class="fa fa-caret-down"></i></a>');

                        //$('a[href=\'#collapse-checkout-confirm\']').trigger('click');
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        console.log('error!');
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
});
//--></script>
<?php echo $footer; ?>