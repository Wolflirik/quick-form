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
        <div id="vtabs" class="vtabs">
          <?php foreach($forms as $key => $form){ ?>
  					<a href="#tab-content-<?php echo $form['id']; ?>" id="content-<?php echo $form['id']; ?>" rel="<?php echo $form['id']; ?>" class="tab<?php if($key==0){ ?> selected<?php } ?> f-<?php echo $form['id']; ?>">
              <b class="b-name"><?php echo $form['name']; ?></b>  <b class="btn"><?php echo $btn_delete; ?></b>
            </a>
          <?php } ?>
          <span id="content-add"><b class="b-name"><?php echo $text_form_add; ?></b>  <b class="btn"><?php echo $btn_plus; ?></b></span>
				</div>

        <?php foreach($forms as $form){ ?>
          <div id="tab-content-<?php echo $form['id']; ?>" class="vtabs-content f-<?php echo $form['id']; ?>" rel="<?php echo $form['id']; ?>">
            <form class="box">
              <div class="heading">
                <h1><?php echo $form['name']; ?></h1>
                <div class="buttons"><a class="button update-form"><?php echo $btn_save; ?></a></div>
              </div>
              <div class="content">
                <br>
                <span><?php echo $form['static_box']; ?></span>
                <br>
                <br>
                <span><?php echo $form['popup_box']; ?></span>
                <br>
                <br>
                <div id="tabs-block-<?php echo $form['id']; ?>" class="htabs htabs--in-v">
    							<a href="#tabs-block-<?php echo $form['id']; ?>-config" style="display: inline;" class="selected tab"><?php echo $text_form_config; ?></a>
    							<a href="#tabs-block-<?php echo $form['id']; ?>-labels" style="display: inline;" class="tab"><?php echo $text_form_set_label; ?></a>
    						</div>

                <div id="tabs-block-<?php echo $form['id']; ?>-config">
                  <table class="form config">
                    <tbody>
                      <tr>
                        <td class="left"><?php echo $text_form_id; ?></td>
                        <td class="left"><?php echo $form['id']; ?></td>
                      </tr>
                      <tr>
                        <td class="left">
                          <label for="qf-<?php echo $form['id']; ?>-name" class="required"><?php echo $text_form_name; ?></label>
                        </td>
                        <td class="left">
                          <input class="machine-name" id="qf-<?php echo $form['id']; ?>-name" type="text" name="name" value="<?php echo $form['name']; ?>"/>
                        </td>
                      </tr>
                      <tr>
                        <td class="left">
                          <label for="qf-<?php echo $form['id']; ?>-class" class="required"><?php echo $text_form_class; ?></label>
                        </td>
                        <td class="left">
                          <input class="machine-name" id="qf-<?php echo $form['id']; ?>-class" type="text" name="class" value="<?php echo $form['class']; ?>"/>
                        </td>
                      </tr>
                      <tr>
                        <td class="left">
                          <label for="qf-<?php echo $form['id']; ?>-text-before"><?php echo $text_form_before; ?></label>
                        </td>
                        <td class="left">
                          <input class="machine-name" id="qf-<?php echo $form['id']; ?>-text-before" type="text" name="text_before" value="<?php echo $form['text_before']; ?>"/>
                        </td>
                      </tr>
                      <tr>
                        <td class="left">
                          <label for="qf-<?php echo $form['id']; ?>-text-after"><?php echo $text_form_after; ?></label>
                        </td>
                        <td class="left">
                          <input class="machine-name" id="qf-<?php echo $form['id']; ?>-text-after" type="text" name="text_after" value="<?php echo $form['text_after']; ?>"/>
                        </td>
                      </tr>
                      <tr>
                        <td class="left">
                          <label for="qf-<?php echo $form['id']; ?>-yandex"><?php echo $text_form_yandex; ?></label>
                        </td>
                        <td class="left">
                          <input class="machine-name" id="qf-<?php echo $form['id']; ?>-yandex" type="text" name="yandex" value="<?php echo $form['yandex']; ?>"/>
                        </td>
                      </tr>
                      <tr>
                        <td class="left">
                          <label for="qf-<?php echo $form['id']; ?>-success"><?php echo $text_form_success; ?></label>
                        </td>
                        <td class="left">
                          <input class="machine-name" id="qf-<?php echo $form['id']; ?>-success" type="text" name="success" value="<?php echo $form['success']; ?>"/>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
                <div id="tabs-block-<?php echo $form['id']; ?>-labels">
                  <p class="attention"><?php echo $text_form_change_warning; ?></p>
                  <?php if(empty($form['labels'])){ ?>
                    <p class="attention attention--count"><?php echo $text_form_labels_warning; ?></p>
                  <?php } ?>
                  <table class="list">
                    <thead>
                      <tr>
                        <td class="left"><b><?php echo $text_form_label_name; ?></b></td>
                        <td class="left"><b><?php echo $text_form_label_sort; ?></b></td>
                        <td></td>
                      </tr>
                    </thead>
                    <tbody>
                      <?php foreach($form['labels'] as $f_label) { ?>
                        <tr class="label-box" data-key="<?php echo $f_label['id']; ?>">
                          <td class="left"><?php echo $f_label['name']; ?></td>
                          <td class="left"><input type="number" name="labels[<?php echo $f_label['id']; ?>][sort]" value="<?php echo $f_label['sort']; ?>"></td>
                          <td class="left"><a class="button remove-label" role="button"><?php echo $btn_minus; ?></a></td>
                        </tr>
                      <?php } ?>
                      <tr class="add-to-form-box">
                        <td class="left" colspan="2">
                          <select class="labels-to-add">
                            <option value=""><?php echo $text_select; ?></option>
                            <?php foreach($labels as $label){ ?>
                              <option value="<?php echo $label['id']; ?>"><?php echo $label['name']; ?></option>
                            <?php }?>
                          </select>
                        </td>
                        <td class="left">
                          <a class="button add-label" role="button"><?php echo $text_form_add_label; ?> <?php echo $btn_plus; ?></a>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>
            </form>
          </div>
        <?php } ?>
      </div>
    </div>
  </div>
</div>
<script><!--
  var tabsInit = function() {
    $('.vtabs .tab').tabs();
    $('.htabs--in-v').each(function(i, el) {
      $(el).find('.tab').tabs();
    });
  };

  var form = {
    'create': function() {
      $.ajax({
    		url: 'index.php?route=module/qf/createForm&token=<?php echo $token; ?>',
    		type: 'get',
    		dataType: 'json',
    		success: function(json) {
    			if (json.hasOwnProperty('success')) {
            var html = '<div id="tab-content-'+json.success.id+'" class="vtabs-content f-'+json.success.id+'" rel="'+json.success.id+'"> <form class="box"> <div class="heading"> <h1>'+json.success.id+'</h1> <div class="buttons"><a class="button update-form"><?php echo $btn_save; ?></a></div> </div> <div class="content"> <p class="attention"><?php echo $text_form_change_warning; ?></p> <div id="tabs-block-'+json.success.id+'" class="htabs htabs--in-v"> <a href="#tabs-block-'+json.success.id+'-config" style="display: inline;" class="selected tab"><?php echo $text_form_config; ?></a> <a href="#tabs-block-'+json.success.id+'-labels" style="display: inline;" class="tab"><?php echo $text_form_set_label; ?></a> </div> <div id="tabs-block-'+json.success.id+'-config"> <table class="form config"> <tbody> <tr> <td class="left"><?php echo $text_form_id; ?></td> <td class="left">'+json.success.id+'</td> </tr> <tr> <td class="left"> <label for="qf-'+json.success.id+'-name" class="required"><?php echo $text_form_name; ?></label> </td> <td class="left"> <input class="machine-name" id="qf-'+json.success.id+'-name" type="text" name="name" value="'+json.success.id+'"/> </td> </tr> <tr> <td class="left"> <label for="qf-'+json.success.id+'-class" class="required"><?php echo $text_form_class; ?></label> </td> <td class="left"> <input class="machine-name" id="qf-'+json.success.id+'-class" type="text" name="class" value="'+json.success.id+'"/> </td> </tr> <tr> <td class="left"> <label for="qf-'+json.success.id+'-text-before"><?php echo $text_form_before; ?></label> </td> <td class="left"> <input class="machine-name" id="qf-'+json.success.id+'-text-before" type="text" name="text_before" value=""/> </td> </tr> <tr> <td class="left"> <label for="qf-'+json.success.id+'-text-after"><?php echo $text_form_after; ?></label> </td> <td class="left"> <input class="machine-name" id="qf-'+json.success.id+'-text-after" type="text" name="text_after" value=""/> </td> </tr> <tr> <td class="left"> <label for="qf-'+json.success.id+'-yandex"><?php echo $text_form_yandex; ?></label> </td> <td class="left"> <input class="machine-name" id="qf-'+json.success.id+'-yandex" type="text" name="yandex" value=""/> </td> </tr><tr> <td class="left"> <label for="qf-'+json.success.id+'-success"><?php echo $text_form_success; ?></label> </td> <td class="left"> <input class="machine-name" id="qf-'+json.success.id+'-success" type="text" name="success" value=""/> </td> </tr> </tbody> </table> </div> <div id="tabs-block-'+json.success.id+'-labels"> <p class="attention"><?php echo $text_form_labels_warning; ?></p> <table class="list"> <tbody> <tr> <td class="left"><b><?php echo $text_form_label_name; ?></b></td> <td class="left"><b><?php echo $text_form_label_sort; ?></b></td> <td></td> </tr> <tr class="add-to-form-box"> <td class="left" colspan="2"> <select class="labels-to-add"> <option value=""><?php echo $text_select; ?></option> <?php foreach($labels as $label){ ?> <option value="<?php echo $label['id']; ?>"><?php echo $label['text_admin']; ?></option> <?php }?> </select> </td> <td class="left"> <a class="button add-label" role="button"><?php echo $text_form_add_label; ?> <?php echo $btn_plus; ?></a> </td> </tr> </tbody> </table> </div> </div> </form> </div>';
            $('.content-main').append(html);
            html = '<a href="#tab-content-'+json.success.id+'" id="content-'+json.success.id+'" rel="'+json.success.id+'" class="tab f-'+json.success.id+'"><b class="b-name">'+json.success.id+'</b>  <b class="btn"><?php echo $btn_delete; ?></b></a>';
            $('#content-add').before(html);
            html = '<a href="'+json.success.link+'" class="f-'+json.success.id+'"style="display: inline;">'+json.success.id+'</a>';
            $('#tabs').append(html);
            tabsInit();
    			}
    		}
    	});
    },

    'update': function(el, fcl = 0) {
      var form = el.closest('form'),
          formData = form.serialize(),
          id = el.closest('form').parent().attr('rel');

      $.ajax({
    		url: 'index.php?route=module/qf/updateForm&token=<?php echo $token; ?>',
    		type: 'post',
        data: formData+'&id='+id+'&change_l='+fcl,
    		dataType: 'json',
    		success: function(json) {
          console.log(json);
          if (json.hasOwnProperty('success')) {
            form.addClass('success-update');
            location.reload();
          }else if(json.hasOwnProperty('error')){
            alert(json.error);
          }
        }
      });
    },

    'delete': function() {
      var id = $(this).parent().attr('rel');
      $.ajax({
    		url: 'index.php?route=module/qf/deleteForm&token=<?php echo $token; ?>',
    		type: 'post',
        data: 'id='+id,
    		dataType: 'json',
    		success: function(json) {
          if (json.hasOwnProperty('success')) {
            $('.f-'+json.success.id).remove();
            tabsInit();
          }else if(json.hasOwnProperty('error')){
            alert(json.error);
          }
        }
      });
    }
  };

  var label = {
    'add': function() {
      var wrap = $(this).closest('.add-to-form-box'),
          select = wrap.find('.labels-to-add'),
          value = select.val(), f = false;

      if(value == ''){
        select.focus();
        return;
      }

      wrap.parent().find('.label-box').each(function(i, el) {
        if(+$(el).attr('data-key') == +value){
          var c = Math.floor((1 + Math.random(0, 99999)) * 0x10000);
          wrap.closest('.list').before('<p class="attention '+c+'"><?php echo $text_form_ident_error; ?></p>');
          setTimeout(function() {
            $('.'+c).remove();
          }, 3000);
          f = true
          return;
        }
      });

      if(f) return;

      var html = '<tr class="label-box" data-key="'+value+'"><td class="left">'+select.find('option:selected').text()+'</td><td class="left"><input type="number" name="labels['+value+'][sort]" value="0"></td><td class="left"><a class="button remove-label" role="button"><?php echo $btn_minus; ?></a></td></tr>';

      wrap.before(html);

      wrap.closest('.list').parent().find('.attention--count').remove();
    },

    'remove': function() {
      var wrap = $(this).closest('.list');
      $(this).closest('.label-box').remove();
      if(wrap.find('.label-box').length == 0){
        wrap.before('<p class="attention attention--count"><?php echo $text_form_labels_warning; ?></p>');
      }
    }
  }

  $(document).ready(function() {
    tabsInit();

    $(document).on('click', '#content-add', form.create);
    $(document).on('mousedown', '.tab .btn', form.delete);
    $(document).on('click', '.update-form', function() {
      var el = $(this);
      $( "#dialog-confirm" ).dialog({
        resizable: false,
        height:200,
        modal: true,
        buttons: {
          "Yes": function() {
            $( this ).dialog( "close" );
            form.update(el, 1);
          },
          "No": function() {
            $( this ).dialog( "close" );
            form.update(el, 0);
          }
        }
      });
    });

    $(document).on('click', '.add-label', label.add);
    $(document).on('click', '.remove-label', label.remove);
  });
--></script>

<div id="dialog-confirm">
  <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span><?php echo $text_form_label_set; ?></p>
</div>
<?php echo $footer; ?>
