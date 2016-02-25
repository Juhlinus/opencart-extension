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
                                <h1>Personuppgifter</h1>
                            </div>
                            <div class="panel-body pers">
                                <b>Personnummer</b>
                                <h1 style="padding-top: 5px; margin-top: 5px;"><input type="text" name="persnr" placeholder="ÅÅMMDD-XXXX" /> <button type="button" class="btn btn-primary">Hämta address</button></h1>
                                <p>Vi hämtar din adress från folkbokföringsregistret. Vill du mata in dina uppgifter manuellt, <a href="#">klicka här</a>.</p>
                            </div>
                            <div class="panel-body corp">
                                <b>Organisationsnummer</b>
                                <h1 style="padding-top: 5px; margin-top: 5px;"><input type="text" name="orgnr" placeholder="XXXXXX-XXXX" /> <button type="button" class="btn btn-primary">Hämta address</button></h1>
                                <p>Vi hämtar din adress från folkbokföringsregistret. Vill du mata in dina uppgifter manuellt, <a href="#">klicka här</a>.</p>
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

    $('#corporate-button').click(function() {
        $('.corp').show();
        $('.pers').hide();
        $('#corporate').removeClass('hidden-fade');
        $('#personal').addClass('hidden-fade');
    });

    $('#personal-button').click(function() {
        $('.corp').hide();
        $('.pers').show();
        $('#corporate').addClass('hidden-fade');
        $('#personal').removeClass('hidden-fade');
    });
});
/*
    $(document).on('change', 'input[name=\'account\']', function() {
       if ($('#collapse-payment-address').parent().find('.panel-heading .panel-title > *').is('a')) {
          if (this.value == 'register') {
             $('#collapse-payment-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_account; ?> <i class="fa fa-caret-down"></i></a>');
         } else {
             $('#collapse-payment-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_address; ?> <i class="fa fa-caret-down"></i></a>');
         }
     } else {
      if (this.value == 'register') {
         $('#collapse-payment-address').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_account; ?>');
     } else {
         $('#collapse-payment-address').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_payment_address; ?>');
     }
 }
});

    <?php if (!$logged) { ?>
        $(document).ready(function() {
            $.ajax({
                url: 'index.php?route=kassa/login',
                dataType: 'html',
                success: function(html) {
                 $('#collapse-checkout-option .panel-body').html(html);

                 $('#collapse-checkout-option').parent().find('.panel-heading .panel-title').html('<a href="#collapse-checkout-option" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_option; ?> <i class="fa fa-caret-down"></i></a>');

                 $('a[href=\'#collapse-checkout-option\']').trigger('click');
             },
             error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
        });
        <?php } else { ?>
            $(document).ready(function() {
                $.ajax({
                    url: 'index.php?route=kassa/payment_address',
                    dataType: 'html',
                    success: function(html) {
                        $('#collapse-payment-address .panel-body').html(html);

                        $('#collapse-payment-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_address; ?> <i class="fa fa-caret-down"></i></a>');

                        $('a[href=\'#collapse-payment-address\']').trigger('click');
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });
            });
            <?php } ?>

// Checkout
$(document).delegate('#button-account', 'click', function() {
    $.ajax({
        url: 'index.php?route=kassa/' + $('input[name=\'account\']:checked').val(),
        dataType: 'html',
        beforeSend: function() {
        	$('#button-account').button('loading');
        },
        complete: function() {
         $('#button-account').button('reset');
     },
     success: function(html) {
        $('.alert, .text-danger').remove();

        $('#collapse-payment-address .panel-body').html(html);

        if ($('input[name=\'account\']:checked').val() == 'register') {
            $('#collapse-payment-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_account; ?> <i class="fa fa-caret-down"></i></a>');
        } else {
            $('#collapse-payment-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_address; ?> <i class="fa fa-caret-down"></i></a>');
        }

        $('a[href=\'#collapse-payment-address\']').trigger('click');
    },
    error: function(xhr, ajaxOptions, thrownError) {
        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
});
});

// Login
$(document).delegate('#button-login', 'click', function() {
    $.ajax({
        url: 'index.php?route=kassa/login/save',
        type: 'post',
        data: $('#collapse-checkout-option :input'),
        dataType: 'json',
        beforeSend: function() {
        	$('#button-login').button('loading');
        },
        complete: function() {
            $('#button-login').button('reset');
        },
        success: function(json) {
            $('.alert, .text-danger').remove();
            $('.form-group').removeClass('has-error');

            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
                $('#collapse-checkout-option .panel-body').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');

				// Highlight any found errors
				$('input[name=\'email\']').parent().addClass('has-error');
				$('input[name=\'password\']').parent().addClass('has-error');
           }
       },
       error: function(xhr, ajaxOptions, thrownError) {
        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
});
});

// Register
$(document).delegate('#button-register', 'click', function() {
    $.ajax({
        url: 'index.php?route=kassa/register/save',
        type: 'post',
        data: $('#collapse-payment-address input[type=\'text\'], #collapse-payment-address input[type=\'date\'], #collapse-payment-address input[type=\'datetime-local\'], #collapse-payment-address input[type=\'time\'], #collapse-payment-address input[type=\'password\'], #collapse-payment-address input[type=\'hidden\'], #collapse-payment-address input[type=\'checkbox\']:checked, #collapse-payment-address input[type=\'radio\']:checked, #collapse-payment-address textarea, #collapse-payment-address select'),
        dataType: 'json',
        beforeSend: function() {
         $('#button-register').button('loading');
     },
     success: function(json) {
        $('.alert, .text-danger').remove();
        $('.form-group').removeClass('has-error');

        if (json['redirect']) {
            location = json['redirect'];
        } else if (json['error']) {
            $('#button-register').button('reset');

            if (json['error']['warning']) {
                $('#collapse-payment-address .panel-body').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
            }

            for (i in json['error']) {
               var element = $('#input-payment-' + i.replace('_', '-'));

               if ($(element).parent().hasClass('input-group')) {
                  $(element).parent().after('<div class="text-danger">' + json['error'][i] + '</div>');
              } else {
                  $(element).after('<div class="text-danger">' + json['error'][i] + '</div>');
              }
          }

				// Highlight any found errors
				$('.text-danger').parent().addClass('has-error');
            } else {
                <?php if ($shipping_required) { ?>
                    var shipping_address = $('#payment-address input[name=\'shipping_address\']:checked').prop('value');

                    if (shipping_address) {
                        $.ajax({
                            url: 'index.php?route=kassa/shipping_method',
                            dataType: 'html',
                            success: function(html) {
							// Add the shipping address
                            $.ajax({
                                url: 'index.php?route=kassa/shipping_address',
                                dataType: 'html',
                                success: function(html) {
                                    $('#collapse-shipping-address .panel-body').html(html);

                                    $('#collapse-shipping-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-shipping-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_shipping_address; ?> <i class="fa fa-caret-down"></i></a>');
                                },
                                error: function(xhr, ajaxOptions, thrownError) {
                                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                }
                            });

                            $('#collapse-shipping-method .panel-body').html(html);

                            $('#collapse-shipping-method').parent().find('.panel-heading .panel-title').html('<a href="#collapse-shipping-method" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_shipping_method; ?> <i class="fa fa-caret-down"></i></a>');

                            $('a[href=\'#collapse-shipping-method\']').trigger('click');

                            $('#collapse-shipping-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_shipping_method; ?>');
                            $('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_payment_method; ?>');
                            $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
                        },
                        error: function(xhr, ajaxOptions, thrownError) {
                            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                        }
                    });
                    } else {
                        $.ajax({
                            url: 'index.php?route=kassa/shipping_address',
                            dataType: 'html',
                            success: function(html) {
                                $('#collapse-shipping-address .panel-body').html(html);

                                $('#collapse-shipping-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-shipping-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_shipping_address; ?> <i class="fa fa-caret-down"></i></a>');

                                $('a[href=\'#collapse-shipping-address\']').trigger('click');

                                $('#collapse-shipping-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_shipping_method; ?>');
                                $('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_payment_method; ?>');
                                $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
                            },
                            error: function(xhr, ajaxOptions, thrownError) {
                                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                            }
                        });
                    }
                    <?php } else { ?>
                        $.ajax({
                            url: 'index.php?route=kassa/payment_method',
                            dataType: 'html',
                            success: function(html) {
                                $('#collapse-payment-method .panel-body').html(html);

                                $('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-method" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_method; ?> <i class="fa fa-caret-down"></i></a>');

                                $('a[href=\'#collapse-payment-method\']').trigger('click');

                                $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
                            },
                            error: function(xhr, ajaxOptions, thrownError) {
                                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                            }
                        });
                        <?php } ?>

                        $.ajax({
                            url: 'index.php?route=kassa/payment_address',
                            dataType: 'html',
                            complete: function() {
                                $('#button-register').button('reset');
                            },
                            success: function(html) {
                                $('#collapse-payment-address .panel-body').html(html);

                                $('#collapse-payment-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_address; ?> <i class="fa fa-caret-down"></i></a>');
                            },
                            error: function(xhr, ajaxOptions, thrownError) {
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

// Payment Address
$(document).delegate('#button-payment-address', 'click', function() {
    $.ajax({
        url: 'index.php?route=kassa/payment_address/save',
        type: 'post',
        data: $('#collapse-payment-address input[type=\'text\'], #collapse-payment-address input[type=\'date\'], #collapse-payment-address input[type=\'datetime-local\'], #collapse-payment-address input[type=\'time\'], #collapse-payment-address input[type=\'password\'], #collapse-payment-address input[type=\'checkbox\']:checked, #collapse-payment-address input[type=\'radio\']:checked, #collapse-payment-address input[type=\'hidden\'], #collapse-payment-address textarea, #collapse-payment-address select'),
        dataType: 'json',
        beforeSend: function() {
        	$('#button-payment-address').button('loading');
        },
        complete: function() {
         $('#button-payment-address').button('reset');
     },
     success: function(json) {
        $('.alert, .text-danger').remove();

        if (json['redirect']) {
            location = json['redirect'];
        } else if (json['error']) {
            if (json['error']['warning']) {
                $('#collapse-payment-address .panel-body').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
            }

            for (i in json['error']) {
               var element = $('#input-payment-' + i.replace('_', '-'));

               if ($(element).parent().hasClass('input-group')) {
                  $(element).parent().after('<div class="text-danger">' + json['error'][i] + '</div>');
              } else {
                  $(element).after('<div class="text-danger">' + json['error'][i] + '</div>');
              }
          }

				// Highlight any found errors
				$('.text-danger').parent().parent().addClass('has-error');
            } else {
                <?php if ($shipping_required) { ?>
                    $.ajax({
                        url: 'index.php?route=kassa/shipping_address',
                        dataType: 'html',
                        success: function(html) {
                            $('#collapse-shipping-address .panel-body').html(html);

                            $('#collapse-shipping-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-shipping-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_shipping_address; ?> <i class="fa fa-caret-down"></i></a>');

                            $('a[href=\'#collapse-shipping-address\']').trigger('click');

                            $('#collapse-shipping-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_shipping_method; ?>');
                            $('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_payment_method; ?>');
                            $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
                        },
                        error: function(xhr, ajaxOptions, thrownError) {
                            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                        }
                    });
                    <?php } else { ?>
                        $.ajax({
                            url: 'index.php?route=kassa/payment_method',
                            dataType: 'html',
                            success: function(html) {
                                $('#collapse-payment-method .panel-body').html(html);

                                $('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-method" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_method; ?> <i class="fa fa-caret-down"></i></a>');

                                $('a[href=\'#collapse-payment-method\']').trigger('click');

                                $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
                            },
                            error: function(xhr, ajaxOptions, thrownError) {
                                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                            }
                        });
                        <?php } ?>

                        $.ajax({
                            url: 'index.php?route=kassa/payment_address',
                            dataType: 'html',
                            success: function(html) {
                                $('#collapse-payment-address .panel-body').html(html);
                            },
                            error: function(xhr, ajaxOptions, thrownError) {
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

// Shipping Address
$(document).delegate('#button-shipping-address', 'click', function() {
    $.ajax({
        url: 'index.php?route=kassa/shipping_address/save',
        type: 'post',
        data: $('#collapse-shipping-address input[type=\'text\'], #collapse-shipping-address input[type=\'date\'], #collapse-shipping-address input[type=\'datetime-local\'], #collapse-shipping-address input[type=\'time\'], #collapse-shipping-address input[type=\'password\'], #collapse-shipping-address input[type=\'checkbox\']:checked, #collapse-shipping-address input[type=\'radio\']:checked, #collapse-shipping-address textarea, #collapse-shipping-address select'),
        dataType: 'json',
        beforeSend: function() {
         $('#button-shipping-address').button('loading');
     },
     success: function(json) {
        $('.alert, .text-danger').remove();

        if (json['redirect']) {
            location = json['redirect'];
        } else if (json['error']) {
            $('#button-shipping-address').button('reset');

            if (json['error']['warning']) {
                $('#collapse-shipping-address .panel-body').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
            }

            for (i in json['error']) {
               var element = $('#input-shipping-' + i.replace('_', '-'));

               if ($(element).parent().hasClass('input-group')) {
                  $(element).parent().after('<div class="text-danger">' + json['error'][i] + '</div>');
              } else {
                  $(element).after('<div class="text-danger">' + json['error'][i] + '</div>');
              }
          }

				// Highlight any found errors
				$('.text-danger').parent().parent().addClass('has-error');
            } else {
                $.ajax({
                    url: 'index.php?route=kassa/shipping_method',
                    dataType: 'html',
                    complete: function() {
                        $('#button-shipping-address').button('reset');
                    },
                    success: function(html) {
                        $('#collapse-shipping-method .panel-body').html(html);

                        $('#collapse-shipping-method').parent().find('.panel-heading .panel-title').html('<a href="#collapse-shipping-method" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_shipping_method; ?> <i class="fa fa-caret-down"></i></a>');

                        $('a[href=\'#collapse-shipping-method\']').trigger('click');

                        $('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_payment_method; ?>');
                        $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');

                        $.ajax({
                            url: 'index.php?route=kassa/shipping_address',
                            dataType: 'html',
                            success: function(html) {
                                $('#collapse-shipping-address .panel-body').html(html);
                            },
                            error: function(xhr, ajaxOptions, thrownError) {
                                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                            }
                        });
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });

                $.ajax({
                    url: 'index.php?route=kassa/payment_address',
                    dataType: 'html',
                    success: function(html) {
                        $('#collapse-payment-address .panel-body').html(html);
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
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

// Guest
$(document).delegate('#button-guest', 'click', function() {
    $.ajax({
        url: 'index.php?route=kassa/guest/save',
        type: 'post',
        data: $('#collapse-payment-address input[type=\'text\'], #collapse-payment-address input[type=\'date\'], #collapse-payment-address input[type=\'datetime-local\'], #collapse-payment-address input[type=\'time\'], #collapse-payment-address input[type=\'checkbox\']:checked, #collapse-payment-address input[type=\'radio\']:checked, #collapse-payment-address input[type=\'hidden\'], #collapse-payment-address textarea, #collapse-payment-address select'),
        dataType: 'json',
        beforeSend: function() {
           $('#button-guest').button('loading');
       },
       success: function(json) {
        $('.alert, .text-danger').remove();

        if (json['redirect']) {
            location = json['redirect'];
        } else if (json['error']) {
            $('#button-guest').button('reset');

            if (json['error']['warning']) {
                $('#collapse-payment-address .panel-body').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
            }

            for (i in json['error']) {
               var element = $('#input-payment-' + i.replace('_', '-'));

               if ($(element).parent().hasClass('input-group')) {
                  $(element).parent().after('<div class="text-danger">' + json['error'][i] + '</div>');
              } else {
                  $(element).after('<div class="text-danger">' + json['error'][i] + '</div>');
              }
          }

				// Highlight any found errors
				$('.text-danger').parent().addClass('has-error');
            } else {
                <?php if ($shipping_required) { ?>
                    var shipping_address = $('#collapse-payment-address input[name=\'shipping_address\']:checked').prop('value');

                    if (shipping_address) {
                        $.ajax({
                            url: 'index.php?route=kassa/shipping_method',
                            dataType: 'html',
                            complete: function() {
                                $('#button-guest').button('reset');
                            },
                            success: function(html) {
							// Add the shipping address
                            $.ajax({
                                url: 'index.php?route=kassa/guest_shipping',
                                dataType: 'html',
                                success: function(html) {
                                    $('#collapse-shipping-address .panel-body').html(html);

                                    $('#collapse-shipping-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-shipping-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_shipping_address; ?> <i class="fa fa-caret-down"></i></a>');
                                },
                                error: function(xhr, ajaxOptions, thrownError) {
                                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                }
                            });

                            $('#collapse-shipping-method .panel-body').html(html);

                            $('#collapse-shipping-method').parent().find('.panel-heading .panel-title').html('<a href="#collapse-shipping-method" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_shipping_method; ?> <i class="fa fa-caret-down"></i></a>');

                            $('a[href=\'#collapse-shipping-method\']').trigger('click');

                            $('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_payment_method; ?>');
                            $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
                        },
                        error: function(xhr, ajaxOptions, thrownError) {
                            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                        }
                    });
                    } else {
                        $.ajax({
                            url: 'index.php?route=kassa/guest_shipping',
                            dataType: 'html',
                            complete: function() {
                                $('#button-guest').button('reset');
                            },
                            success: function(html) {
                                $('#collapse-shipping-address .panel-body').html(html);

                                $('#collapse-shipping-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-shipping-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_shipping_address; ?> <i class="fa fa-caret-down"></i></a>');

                                $('a[href=\'#collapse-shipping-address\']').trigger('click');

                                $('#collapse-shipping-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_shipping_method; ?>');
                                $('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_payment_method; ?>');
                                $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
                            },
                            error: function(xhr, ajaxOptions, thrownError) {
                                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                            }
                        });
                    }
                    <?php } else { ?>
                        $.ajax({
                            url: 'index.php?route=kassa/payment_method',
                            dataType: 'html',
                            complete: function() {
                                $('#button-guest').button('reset');
                            },
                            success: function(html) {
                                $('#collapse-payment-method .panel-body').html(html);

                                $('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-method" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_method; ?> <i class="fa fa-caret-down"></i></a>');

                                $('a[href=\'#collapse-payment-method\']').trigger('click');

                                $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
                            },
                            error: function(xhr, ajaxOptions, thrownError) {
                                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                            }
                        });
                        <?php } ?>
                    }
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
            });
});

// Guest Shipping
$(document).delegate('#button-guest-shipping', 'click', function() {
    $.ajax({
        url: 'index.php?route=kassa/guest_shipping/save',
        type: 'post',
        data: $('#collapse-shipping-address input[type=\'text\'], #collapse-shipping-address input[type=\'date\'], #collapse-shipping-address input[type=\'datetime-local\'], #collapse-shipping-address input[type=\'time\'], #collapse-shipping-address input[type=\'password\'], #collapse-shipping-address input[type=\'checkbox\']:checked, #collapse-shipping-address input[type=\'radio\']:checked, #collapse-shipping-address textarea, #collapse-shipping-address select'),
        dataType: 'json',
        beforeSend: function() {
        	$('#button-guest-shipping').button('loading');
        },
        success: function(json) {
            $('.alert, .text-danger').remove();

            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
                $('#button-guest-shipping').button('reset');

                if (json['error']['warning']) {
                    $('#collapse-shipping-address .panel-body').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }

                for (i in json['error']) {
                   var element = $('#input-shipping-' + i.replace('_', '-'));

                   if ($(element).parent().hasClass('input-group')) {
                      $(element).parent().after('<div class="text-danger">' + json['error'][i] + '</div>');
                  } else {
                      $(element).after('<div class="text-danger">' + json['error'][i] + '</div>');
                  }
              }

				// Highlight any found errors
				$('.text-danger').parent().addClass('has-error');
            } else {
                $.ajax({
                    url: 'index.php?route=kassa/shipping_method',
                    dataType: 'html',
                    complete: function() {
                        $('#button-guest-shipping').button('reset');
                    },
                    success: function(html) {
                        $('#collapse-shipping-method .panel-body').html(html);

                        $('#collapse-shipping-method').parent().find('.panel-heading .panel-title').html('<a href="#collapse-shipping-method" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_shipping_method; ?> <i class="fa fa-caret-down"></i>');

                        $('a[href=\'#collapse-shipping-method\']').trigger('click');

                        $('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_payment_method; ?>');
                        $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
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

$(document).delegate('#button-shipping-method', 'click', function() {
    $.ajax({
        url: 'index.php?route=kassa/shipping_method/save',
        type: 'post',
        data: $('#collapse-shipping-method input[type=\'radio\']:checked, #collapse-shipping-method textarea'),
        dataType: 'json',
        beforeSend: function() {
        	$('#button-shipping-method').button('loading');
        },
        success: function(json) {
            $('.alert, .text-danger').remove();

            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
                $('#button-shipping-method').button('reset');
                
                if (json['error']['warning']) {
                    $('#collapse-shipping-method .panel-body').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }
            } else {
                $.ajax({
                    url: 'index.php?route=kassa/payment_method',
                    dataType: 'html',
                    complete: function() {
                        $('#button-shipping-method').button('reset');
                    },
                    success: function(html) {
                        $('#collapse-payment-method .panel-body').html(html);

                        $('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-method" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_method; ?> <i class="fa fa-caret-down"></i></a>');

                        $('a[href=\'#collapse-payment-method\']').trigger('click');

                        $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
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

$(document).delegate('#button-payment-method', 'click', function() {
    $.ajax({
        url: 'index.php?route=kassa/payment_method/save',
        type: 'post',
        data: $('#collapse-payment-method input[type=\'radio\']:checked, #collapse-payment-method input[type=\'checkbox\']:checked, #collapse-payment-method textarea'),
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
                $('#collapse-payment-method .panel-body').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
            }
        } else {
            $.ajax({
                url: 'index.php?route=kassa/confirm',
                dataType: 'html',
                complete: function() {
                    $('#button-payment-method').button('reset');
                },
                success: function(html) {
                    $('#collapse-checkout-confirm .panel-body').html(html);

                    $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<a href="#collapse-checkout-confirm" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_confirm; ?> <i class="fa fa-caret-down"></i></a>');

                    $('a[href=\'#collapse-checkout-confirm\']').trigger('click');
                },
                error: function(xhr, ajaxOptions, thrownError) {
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
*/
//--></script>
<?php echo $footer; ?>