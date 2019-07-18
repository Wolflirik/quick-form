<?php if(!empty($form['labels'])){ ?>
  <div class="qf-box <?php echo $form['class']; ?>">
    <div class="qf-box__head">
      <?php if($product){ ?>
        <?php echo $product['name']; ?>
      <?php }else{ ?>
        <?php echo $form['name']; ?>
      <?php }?>
      <?php if($popup){ ?>
        <button class="qf-box__btn qf-box__btn--close">&times;</button>
      <?php } ?>
    </div>
    <div class="qf-box__body">
      <?php if(!isset($success)){ ?>
        <form action="<?php echo $action; ?>" method="POST" class="qf-box__form">
          <span class="qf-box__text"><?php echo $form['text_before']; ?></span>
          <?php foreach($form['labels'] as $key => $label) { ?>
            <div class="qf-box__group">
              <?php if((int)$label['type'] == 3){ ?>

                <label class="qf-box__group-label"
                  for="<?php echo $key.'-'.$label['id'].'-'.$form['id']; ?>">
                  <?php echo $label['text']; ?>
                </label>
                <textarea class="qf-box__group-textarea"
                  name="<?php echo $key; ?>"
                  id="<?php echo $key.'-'.$label['id'].'-'.$form['id']; ?>"
                  <?php if(!empty($label['placeholder'])){ ?>
                    placeholder="<?php echo $label['placeholder']; ?>"
                  <?php } ?>><?php if(!empty($label['value'])){ ?><?php echo $label['value']; ?><?php } ?></textarea>

              <?php } ?>
              <?php if((int)$label['type'] == 1){ ?>

                <label class="qf-box__group-label"
                  for="<?php echo $key.'-'.$label['id'].'-'.$form['id']; ?>">
                  <?php echo $label['text']; ?>
                </label>
                <input type="text" class="qf-box__group-inp"
                  name="<?php echo $key; ?>"
                  id="<?php echo $key.'-'.$label['id'].'-'.$form['id']; ?>"
                  <?php if(!empty($label['value'])){ ?>
                    value="<?php echo $label['value']; ?>"
                  <?php } ?>
                  <?php if(!empty($label['placeholder'])){ ?>
                    placeholder="<?php echo $label['placeholder']; ?>"
                  <?php } ?>>

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

              <?php if(isset(${'error_'.$key})){ ?>
                <span class="qf-box__group-danger"><?php echo ${'error_'.$key}; ?></span>
              <?php } ?>
            </div>
          <?php } ?>
          <?php if(isset($error_not_label)){ ?>
            <span class="qf-box__group-danger"><?php echo $error_not_label; ?></span>
          <?php } ?>
          <button type="submit" class="qf-box__btn"><?php echo $button_submit; ?></button>
          <span class="qf-box__text"><?php echo $form['text_after']; ?></span>
        </form>
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
