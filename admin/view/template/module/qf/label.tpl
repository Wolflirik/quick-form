<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $btn_cancel; ?></a></div>
    </div>
    <div class="content">
      <div id="tabs" class="htabs">
        <?php foreach($tabs as $tab){ ?>
  				<a href="<?php echo $tab['link']; ?>" class="<?php if($tab['id']){ ?>f-<?php echo $tab['id']; ?><?php } if($tab['link']==$page){ ?> selected<?php } ?>"style="display: inline;"><?php echo $tab['name']; ?></a>
        <?php } ?>
			</div>

      <div class="content-main">
        <table class="list">
          <thead>
            <tr>
              <td class="left"><b><?php echo $text_label_col_type; ?></b></td>
              <td class="left"><b><?php echo $text_label_col_name; ?></b></td>
              <td class="left"><b><?php echo $text_label_col_text_catalog; ?></b></td>
              <td class="left"><b><?php echo $text_label_col_text_admin; ?></b></td>
              <td class="left"><b><?php echo $text_label_col_placeholder; ?></b></td>
              <td class="left"><b><?php echo $text_label_col_pattern; ?></b></td>
              <td class="left"><b><?php echo $text_label_col_min; ?>/<?php echo $text_label_col_max; ?></b></td>
              <td class="left"><b><?php echo $text_label_col_error_text; ?></b></td>
              <td></td>
            </tr>
          </thead>
          <tbody>
            <?php foreach($labels as $label) { ?>
              <tr class="label-box">
                <td class="left">
                  <input type="hidden" name="id" value="<?php echo $label['id']; ?>">
                  <input type="hidden" name="type" value="<?php echo $label['type']; ?>">
                  <?php echo ${'text_label_add_type_'.$label['type']}; ?>
                </td>
                <td class="left"><input type="text" name="name" title="<?php echo $text_label_name; ?>" value="<?php echo $label['name']; ?>"></td>
                <td class="left"><input type="text" name="text" title="<?php echo $text_label_text_catalog; ?>" value="<?php echo $label['text']; ?>"></td>
                <td class="left"><input type="text" name="text_admin" title="<?php echo $text_label_text_admin; ?>" value="<?php echo $label['text_admin']; ?>"></td>
                <td class="left"><input type="text" name="placeholder" title="<?php echo $text_label_placeholder; ?>" value="<?php echo $label['placeholder']; ?>" <?php if($label['type']==2){ ?> disabled<?php } ?>></td>
                <td class="left"><input type="text" name="pattern" title="<?php echo $text_label_pattern; ?>" value="<?php echo $label['pattern']; ?>"<?php if($label['type']==2){ ?> disabled<?php } ?>></td>
                <td class="left"><input type="number" name="min" title="<?php echo $text_label_min; ?>" value="<?php echo $label['min']; ?>" class="min-max"<?php if($label['type']==2){ ?> title="<?php echo $text_label_checkbox_min; ?>"<?php } ?>>/<input type="number" name="max" title="<?php echo $text_label_max; ?>" value="<?php echo $label['max']; ?>" class="min-max" <?php if($label['type']==2){ ?> disabled<?php } ?>></td>
                <td class="left"><input type="text" name="text_error" title="<?php echo $text_label_error_text; ?>" value="<?php echo $label['text_error']; ?>"<?php if($label['type']==2){ ?> title="<?php echo $text_label_checkbox_error_text; ?>"<?php } ?>></td>
                <td class="right"><a class="button update-label" role="button"><?php echo $btn_refresh; ?></a>&nbsp;<a class="button delete-label" role="button"><?php echo $btn_delete; ?></a></td>
              </tr>
            <?php } ?>
            <tr class="add-label-box">
              <td class="right" colspan="8">
                <select class="label-type">
                  <option value="1"><?php echo $text_label_add_type_1; ?></option>
                  <option value="2"><?php echo $text_label_add_type_2; ?></option>
                  <option value="3"><?php echo $text_label_add_type_3; ?></option>
                </select>
              </td>
              <td class="right"><a class="button create-label"><?php echo $btn_plus; ?></a></td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>
<script><!--
  var label = {
    'create': function() {
      var table = $(this).closest('.list'),
          select = table.find('.label-type'),
          type = +select.val(),
          typeText = select.find('option:selected').text();

      $.ajax({
        url: 'index.php?route=module/qf/createLabel&token=<?php echo $token; ?>',
        type: 'post',
        data: 'type='+type,
        dataType: 'json',
        success: function(json) {
          if (json.hasOwnProperty('success')) {
            var html = '<tr class="label-box"> <td class="left"> <input type="hidden" name="id" value="'+json.success.id+'"> <input type="hidden" name="type" value="'+type+'"> '+typeText+' </td> <td class="left"><input type="text" name="name" title="<?php echo $text_label_name; ?>" value="'+json.success.name+'"></td> <td class="left"><input type="text" name="text" title="<?php echo $text_label_text_catalog; ?>" value="'+json.success.id+'"></td> <td class="left"><input type="text" name="text_admin" title="<?php echo $text_label_text_admin; ?>" value="'+json.success.id+'"></td> <td class="left"><input type="text" name="placeholder" title="<?php echo $text_label_placeholder; ?>" value=""'+(type==2?' disabled':'')+'></td> <td class="left"><input type="text" name="pattern" title="<?php echo $text_label_pattern; ?>" value=""'+(type==2?' disabled':'')+'></td> <td class="left"><input type="number" name="min" title="<?php echo $text_label_min; ?>" value="-1" class="min-max"'+(type==2?' title="<?php echo $text_label_checkbox_min; ?>"':'')+'>/<input type="number" name="max" title="<?php echo $text_label_max; ?>" value="-1" class="min-max"'+(type==2?' disabled':'')+'></td> <td class="left"><input type="text" name="text_error" title="<?php echo $text_label_error_text; ?>" value=""'+(type==2?' title="<?php echo $text_label_checkbox_error_text; ?>"':'')+'></td> <td class="right"><a class="button update-label" role="button"><?php echo $btn_refresh; ?></a>&nbsp;<a class="button delete-label" role="button"><?php echo $btn_delete; ?></a></td> </tr>';
            table.find('.add-label-box').before(html);
          }
        }
      });
    },

    'delete': function() {
      var labelBox = $(this).closest('.label-box'),
          id = +labelBox.find('input[name="id"]').val()
      $.ajax({
        url: 'index.php?route=module/qf/checkTie&token=<?php echo $token; ?>',
        type: 'post',
        data: 'id='+id,
        dataType: 'json',
        success: function(json) {
          if (json.hasOwnProperty('success')) {
            if(json.success.tie == 'to_tie'){
              if(confirm('<?php echo $text_label_warning_tie; ?>')){
                $.ajax({
              		url: 'index.php?route=module/qf/deleteLabel&token=<?php echo $token; ?>',
              		type: 'post',
                  data: 'id='+id,
              		dataType: 'json',
              		success: function(json) {
                    if (json.hasOwnProperty('success')) {
                      labelBox.remove();
                    }else if(json.hasOwnProperty('error')){
                      alert(json.error);
                    }
                  }
                });
              }
            }else if(json.success.tie == 'not_tie'){
              $.ajax({
                url: 'index.php?route=module/qf/deleteLabel&token=<?php echo $token; ?>',
                type: 'post',
                data: 'id='+id,
                dataType: 'json',
                success: function(json) {
                  if (json.hasOwnProperty('success')) {
                    labelBox.remove();
                  }else if(json.hasOwnProperty('error')){
                    alert(json.error);
                  }
                }
              });
            }
          }
        }
      });
    },

    'update': function() {
      var labelBox = $(this).closest('.label-box'), formData = '',
          rows = labelBox.find('input').length;

      labelBox.find('input').each(function(i, el){
        formData += $(el).attr('name')+'='+encodeURIComponent($(el).val());
        if(rows-1>i){
          formData += '&';
        }
      });

      $.ajax({
        url: 'index.php?route=module/qf/updateLabel&token=<?php echo $token; ?>',
        type: 'post',
        data: formData,
        dataType: 'json',
        success: function(json) {
          if (json.hasOwnProperty('success')) {
            var c = 'success-update-'+Math.floor((1 + Math.random(0, 99999)) * 0x10000);
            labelBox.addClass(c);
            setTimeout(function() {
              labelBox.removeClass(c);
            }, 400);
          }else if(json.hasOwnProperty('error')){
            alert(json.error);
          }
        }
      });
    }
  };

  $(document).ready(function() {
    $(document).on('click', '.create-label', label.create);
    $(document).on('click', '.delete-label', label.delete);
    $(document).on('click', '.update-label', label.update);
  });
--></script>
<?php echo $footer; ?>
