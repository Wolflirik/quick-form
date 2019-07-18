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
              <?php foreach($form['labels'] as $label){ ?>
                <td class="left"><b><?php echo $label['text_admin']; ?></b></td>
              <?php } ?>
              <?php if(isset($contents[0]['values']['pid'])){ ?>
                <td class="left"><b><?php echo $text_product_id; ?></b></td>
              <?php }?>
              <td></td>
            </tr>
          </thead>
          <tbody>
            <?php foreach($contents as $content) { ?>
              <tr class="content-box">
                <?php foreach($content['values'] as $key => $value){ ?>
                  <?php if($key == 'pid'){ ?>
                    <td class="left"><a href="<?php echo $product_link.'&product_id='.$value; ?>" target="_blank" noreferer><?php echo $value; ?></a></td>
                  <?php }else{ ?>
                    <td class="left"><?php echo $value; ?></td>
                  <?php } ?>
                <?php } ?>
                <td class="right"><a class="button delete-content" data-id="<?php echo $content['id']; ?>"><?php echo $btn_delete; ?></a></td>
              </tr>
            <?php } ?>
          </tbody>
        </table>
        <div class="pagination"><?php echo $pagination; ?></div>
      </div>
    </div>
  </div>
</div>
<script><!--
  var content = {
    'delete': function() {
      var id = $(this).attr("data-id");
      $.ajax({
        url: 'index.php?route=module/qf/deleteContent&token=<?php echo $token; ?>',
        type: 'post',
        data: 'id='+id,
        dataType: 'json',
        success: function(json) {
          if (json.hasOwnProperty('success')) {
            $(document).find('.delete-content[data-id='+json.success.id+']').closest('.content-box').remove();
          }else if(json.hasOwnProperty('error')){
            alert(json.error);
          }
        }
      });
    }
  }
  $(document).ready(function() {
    $('.delete-content').on('click', content.delete);
  });
--></script>
<?php echo $footer; ?>
