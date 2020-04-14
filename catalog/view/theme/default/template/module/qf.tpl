<?php if(!empty($form['labels'])){ ?>
  <div class="qf-box <?php echo $form['class']; ?>">
    <?php if($popup){ ?>
      <div class="qf-box__head">
        <?php if($product){ ?>
          <?php echo $product['name']; ?>
        <?php }else{ ?>
          <?php echo $form['name']; ?>
        <?php }?>
        <button class="qf-box__btn qf-box__btn--close">&times;</button>
      </div>
    <?php } ?>
    <div class="qf-box__body">
      <?php if(!isset($success)){ ?>
        <form action="<?php echo $action; ?>" method="POST" class="qf-box__form">
          <span class="qf-box__text"><?php echo htmlspecialchars_decode($form['text_before']); ?></span>
          <?php $mask = array(); ?>
          <?php foreach($form['labels'] as $key => $label) { ?>
            <div class="qf-box__group <?php if(isset(${'error_'.$key})){ ?> qf-box__group--error<?php } ?>">
              <?php if((int)$label['type'] == 4){ ?>
                <?php if(!empty($label['text'])){ ?>
                  <span class="qf-box__group-label"
                    for="<?php echo $key.'-'.$label['id'].'-'.$form['id']; ?>">
                    <?php echo $label['text']; ?>
                  </span>
                <?php } ?>
                <label>
                  <input type="file" class="qf-box__group-file <?php echo $key.'-'.$label['id'].'-'.$form['id']; ?>"
                         name="<?php echo $key; ?>"></input>
                </label>
              <?php } ?>
              <?php if((int)$label['type'] == 3){ ?>
                <?php if(!empty($label['text'])){ ?>
                  <label class="qf-box__group-label"
                    for="<?php echo $key.'-'.$label['id'].'-'.$form['id']; ?>">
                    <?php echo $label['text']; ?>
                  </label>
                <?php } ?>
                <textarea class="qf-box__group-textarea <?php echo $key.'-'.$label['id'].'-'.$form['id']; ?>"
                  name="<?php echo $key; ?>"
                  <?php if(!empty($label['placeholder'])){ ?>
                    placeholder="<?php echo $label['placeholder']; ?>"
                  <?php } ?>><?php if(!empty($label['value'])){ ?><?php echo $label['value']; ?><?php } ?></textarea>
                  <?php if(!empty($label['pattern'])){ $mask[$key.'-'.$label['id'].'-'.$form['id']] = $key; } ?>

              <?php } ?>
              <?php if((int)$label['type'] == 1){ ?>
                <?php if(!empty($label['text'])){ ?>
                  <label class="qf-box__group-label"
                    for="<?php echo $key.'-'.$label['id'].'-'.$form['id']; ?>">
                    <?php echo $label['text']; ?>
                  </label>
                <?php } ?>
                <input type="text" class="qf-box__group-inp <?php echo $key.'-'.$label['id'].'-'.$form['id']; ?>"
                  name="<?php echo $key; ?>"
                  <?php if(!empty($label['value'])){ ?>
                    value="<?php echo $label['value']; ?>"
                  <?php } ?>
                  <?php if(!empty($label['placeholder'])){ ?>
                    placeholder="<?php echo $label['placeholder']; ?>"
                  <?php } ?>>
                <?php if(!empty($label['pattern'])){ $mask[$key.'-'.$label['id'].'-'.$form['id']] = $key; } ?>

              <?php } ?>
              <?php if((int)$label['type'] == 2){ ?>

                <label class="qf-box__group-checkbox qf-checkbox">
                  <input type="checkbox" class="qf-checkbox__inp"
                    name="<?php echo $key; ?>"
                    value="1"
                    <?php if(!empty($label['value']) && (int)$label['value'] == 1){ ?>
                      checked
                    <?php }else{ ?>
                    <?php } ?>>
                  <span class="qf-checkbox__label"><?php echo $label['text']; ?></span>
                </label>

              <?php } ?>

              <?php if(isset(${'error_'.$key}) && !empty(${'error_'.$key})){ ?>
                <span class="qf-box__group-danger"><?php echo ${'error_'.$key}; ?></span>
              <?php } ?>
            </div>
          <?php } ?>
          <?php if(isset($error_not_label)){ ?>
            <span class="qf-box__group-danger"><?php echo $error_not_label; ?></span>
          <?php } ?>
          <button type="submit" class="qf-box__btn">
            <?php if(!empty($form['submit'])){ ?>
              <?php echo $form['submit']; ?>
            <?php }else{ ?>
              <?php echo $button_submit; ?>
            <?php } ?>
          </button>
          <span class="qf-box__text"><?php echo htmlspecialchars_decode($form['text_after']); ?></span>
        </form>
        <?php if(!empty($mask)) { ?>
          <script type="text/javascript">
            jQuery.cachedScript = function( url, options ) {
              options = $.extend( options || {}, {
                dataType: "script",
                url: url
              });
              return jQuery.ajax( options );
            };
             
            $.cachedScript('https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.15/jquery.mask.min.js').done(function( script, textStatus ) {
              <?php foreach($mask as $k => $m){ ?>
                $('.<?php echo $k; ?>').mask('<?php echo $form['labels'][$m]['pattern']; ?>', {placeholder: '<?php echo $form['labels'][$m]['placeholder']; ?>'});
              <?php } ?>
            });
          </script>
        <?php } ?>
      <?php }else{ ?>
        <span class="qf-box__text"><?php echo $success; ?></span>
        <?php if(!empty($form['yandex'])) { ?>
          <script type="text/javascript">
            <?php echo $form['yandex']; ?>
          </script>
        <?php } ?>
      <?php } ?>
    </div>
  </div>
<?php } ?>
