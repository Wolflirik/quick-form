<?php
class ModelModuleQf extends Model {
  public function getFormByName($name) {
    $result = $this->db->query("SELECT * FROM " . DB_PREFIX . "qf WHERE class='" . $this->db->escape($name) . "'");
    if(!empty($result->row)){
      $labels = $this->db->query("SELECT * FROM " . DB_PREFIX . "qf_label_to_form l2f LEFT JOIN " . DB_PREFIX . "qf_label l ON(l2f.Label_id = l.id) WHERE l2f.form_id='" . (int)$result->row['id'] . "' ORDER BY l2f.sort ASC");

      $labels_arr = array();
      if(!empty($labels->rows)){
        foreach($labels->rows as $label){
          $labels_arr[$label['name']] = array(
            'id' => $label['id'],
            'type' => $label['type'],
            'text' => $label['text'],
            'text_admin' => $label['text_admin'],
            'value' => '',
            'placeholder' => $label['placeholder'],
            'pattern' => $label['pattern'],
            'min' => $label['min'],
            'max' => $label['max'],
            'text_error' => $label['text_error']
          );
        }
      }

      $data = array(
        'id' => $result->row['id'],
        'name' => $result->row['name'],
        'class' => $result->row['class'],
        'text_before' => $result->row['text_before'],
        'text_after' => $result->row['text_after'],
        'yandex' => $result->row['yandex'],
        'success' => $result->row['success'],
        'email' => $result->row['email'],
        'labels' => $labels_arr
      );
      return $data;
    }else{
      return false;
    }
  }

  public function addContent($data) {
    $form_id = $data['form_id'];
    unset($data['form_id']);
    $value = serialize($data);
    $this->db->query("INSERT INTO " . DB_PREFIX . "qf_content (value, form_id) VALUES ('" . $this->db->escape($value) . "', '" . (int)$form_id . "')");
  }
}
?>
