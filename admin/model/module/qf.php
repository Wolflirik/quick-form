<?php
class ModelModuleQf extends Model {
  public function getFormById($id) {
    $result = $this->db->query("SELECT * FROM " . DB_PREFIX . "qf WHERE id=" . (int)$id);
    if(!empty($result->row)){
      $labels = $this->db->query("SELECT * FROM " . DB_PREFIX . "qf_label_to_form l2f LEFT JOIN " . DB_PREFIX . "qf_label l ON(l2f.Label_id = l.id) WHERE l2f.form_id='" . (int)$id . "' ORDER BY l2f.sort ASC");
      $data = array(
        'id' => $result->row['id'],
        'name' => $result->row['name'],
        'class' => $result->row['class'],
        'text_before' => $result->row['text_before'],
        'text_after' => $result->row['text_after'],
        'yandex' => $result->row['yandex'],
        'success' => $result->row['success'],
        'email' => $result->row['email'],
        'submit' => $result->row['submit'],
        'static_box' => str_replace('&amp;', '&', htmlspecialchars(
          sprintf($this->language->get('text_static_box'),
          str_replace('/admin', '',
          $this->url->link('module/qf',
          'fn='.$result->row['class'], 'SSL'))))),
        'popup_box' => str_replace('&amp;', '&', htmlspecialchars(
          sprintf($this->language->get('text_popup_box'),
          str_replace('/admin', '',
          $this->url->link('module/qf',
          'fn='.$result->row['class'], 'SSL')), $result->row['name']))),
        'labels' => !empty($labels->rows)?$labels->rows:array()
      );
      return $data;
    }else{
      return false;
    }
  }

  public function getLabelById($id) {
    $result = $this->db->query("SELECT * FROM " . DB_PREFIX . "qf_label WHERE id=" . (int)$id);
    if(!empty($result->row)){
      return $result;
    }else{
      return false;
    }
  }

	public function getForms() {
    $results = $this->db->query("SELECT id FROM " . DB_PREFIX . "qf");

    if(!empty($results->rows)){
      $data = array();
      foreach($results->rows as $row){
        $data[] = $this->getFormById($row['id']);
      }
      return $data;
    }else{
      return array();
    }
  }

  public function getLabels() {
    $results = $this->db->query("SELECT * FROM " . DB_PREFIX . "qf_label");

    if(!empty($results->rows)){
      return $results->rows;
    }else{
      return array();
    }
  }

  public function getTabs() {
    $results = $this->db->query("SELECT id, name FROM " . DB_PREFIX . "qf");

    if(!empty($results->rows)){
      return $results->rows;
    }else{
      return array();
    }
  }

  public function createForm() {
    $this->db->query("INSERT INTO " . DB_PREFIX . "qf (name, class, text_before, text_after, yandex, success, email, submit) VALUES ('', '', '', '', '', '', '', '')");
    $id = $this->db->getLastId();
    $this->db->query("UPDATE " . DB_PREFIX . "qf SET name='" . (int)$id . "', class='" . (int)$id . "' WHERE id='" . (int)$id . "'");
    return $id;
  }

  public function deleteForm($data) {
    $this->db->query("DELETE FROM " . DB_PREFIX . "qf WHERE id='" . (int)$data['id'] . "'");
    $this->db->query("DELETE FROM " . DB_PREFIX . "qf_label_to_form WHERE form_id='" . (int)$data['id'] . "'");
    $this->db->query("DELETE FROM " . DB_PREFIX . "qf_content WHERE form_id='" . (int)$data['id'] . "'");
    return $data['id'];
  }

  public function updateForm($data) {
    if((int)$data['change_l'] == 1){
      $this->db->query("DELETE FROM " . DB_PREFIX . "qf_label_to_form WHERE form_id='" . (int)$data['id'] . "'");
      $this->db->query("DELETE FROM " . DB_PREFIX . "qf_content WHERE form_id='" . (int)$data['id'] . "'");
    }

    $this->db->query("UPDATE " . DB_PREFIX . "qf SET name='" . $this->db->escape($data['name']) . "', class='" . $this->db->escape($data['class']) . "', text_after='" . $this->db->escape($data['text_after']) . "', text_before='" . $this->db->escape($data['text_before']) . "', yandex='" . $this->db->escape($data['yandex']) . "', success='" . $this->db->escape($data['success']) . "', email='" . $this->db->escape($data['email']) . "', submit='" . $this->db->escape($data['submit']) . "' WHERE id='" . (int)$data['id'] . "'");
    if(isset($data['labels']) && !empty($data['labels']) && (int)$data['change_l'] == 1){
      foreach($data['labels'] as $key => $label){
        $this->db->query("INSERT INTO " . DB_PREFIX . "qf_label_to_form (label_id, form_id, sort) VALUES ('" . (int)$key . "', '" . (int)$data['id'] . "', '" . $label['sort'] . "')");
      }
    }
    return true;
  }

  public function createLabel($data) {
    $this->db->query("INSERT INTO " . DB_PREFIX . "qf_label (name, type, text, text_admin, placeholder, pattern, min, max, text_error) VALUES ('', '" . (int)$data['type'] . "', '', '', '', '', '-1', '-1', '')");
    $id = $this->db->getLastId();
    $name = floor((1 + rand(0, 99999)) * 0x10000);
    $this->db->query("UPDATE " . DB_PREFIX . "qf_label SET name='" . $name . "', text_admin='" . (int)$id . "' WHERE id='" . (int)$id . "'");
    return array(
      'id' => $id,
      'name' => $name
    );
  }

  public function checkTieLabel($data){
    if($this->db->query("SELECT COUNT(*) as count FROM " . DB_PREFIX . "qf_label_to_form WHERE label_id='" . (int)$data['id'] . "'")->row['count'] > 0){
      return true;
    }else{
      return false;
    }
  }

  public function checkUniqueLabelName($data){
    if((int)$this->db->query("SELECT COUNT(*) as count FROM " . DB_PREFIX . "qf_label WHERE name='" . $this->db->escape($data['name']) . "' AND id != '" . (int)$data['id'] . "'")->row['count'] >= 1){
      return true;
    }else{
      return false;
    }
  }

  public function deleteLabel($data) {
    $results = $this->db->query("SELECT form_id as id FROM " . DB_PREFIX . "qf_label_to_form WHERE label_id='" . (int)$data['id'] . "'");

    if(!empty($results->rows)){
      $forms = array_unique($results->rows);
      foreach($forms as $form){
        $this->db->query("DELETE FROM " . DB_PREFIX . "qf_content WHERE form_id='" . (int)$form['id'] . "'");
      }
    }

    $this->db->query("DELETE FROM " . DB_PREFIX . "qf_label_to_form WHERE label_id='" . (int)$data['id'] . "'");
    $this->db->query("DELETE FROM " . DB_PREFIX . "qf_label WHERE id='" . (int)$data['id'] . "'");
    return $data['id'];
  }

  public function updateLabel($data) {
    $this->db->query("UPDATE " . DB_PREFIX . "qf_label
    SET name='" . $this->db->escape($data['name']) . "',
    text='" . $this->db->escape($data['text']) . "',
    text_admin='" . $this->db->escape($data['text_admin']) . "',
    placeholder='" . $this->db->escape($data['placeholder']) . "',
    pattern='" . $this->db->escape($data['pattern']) . "',
    min='" . $this->db->escape($data['min']) . "',
    max='" . $this->db->escape($data['max']) . "',
    text_error='" . $this->db->escape($data['text_error']) . "'
    WHERE id='" . (int)$data['id'] . "'");

    return true;
  }

  public function getContentTotal($data) {
    return $this->db->query("SELECT COUNT(*) as count FROM " . DB_PREFIX . "qf_content WHERE form_id='" . (int)$data['f_id'] . "'")->row['count'];
  }

  public function getContent($data) {
    $results = $this->db->query("SELECT * FROM " . DB_PREFIX . "qf_content WHERE form_id='" . (int)$data['f_id'] . "' ORDER BY date_add DESC LIMIT " . (int)$data['start'] . ", " . (int)$data['limit']);
    if(!empty($results->rows)){
      $data = array();
      foreach($results->rows as $key => $row){
        $data[$key] = array(
          'id' => $row['id'],
          'values' => unserialize($row['value']),
          'form_id' => $row['form_id'],
          'date_add' => $row['date_add']
        );
      }
      return $data;
    }else{
      return array();
    }
  }

  public function deleteContent($data) {
    $this->db->query("DELETE FROM " . DB_PREFIX . "qf_content WHERE id='" . (int)$data['id'] . "'");
    return $data['id'];
  }

  public function install() {
    $this->db->query("
    CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "qf` (
      `id` int(11) NOT NULL AUTO_INCREMENT,
      `name` varchar(255) NOT NULL,
      `class` varchar(100) NOT NULL,
      `text_before` varchar(500) NOT NULL,
      `text_after` varchar(500) NOT NULL,
      `yandex` varchar(200) NOT NULL,
      `success` varchar(255) NOT NULL,
      `submit` varchar(60) NOT NULL,
      `email` text NOT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8");

    $this->db->query("
    CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "qf_content` (
      `id` int(11) NOT NULL AUTO_INCREMENT,
      `form_id` int(11) NOT NULL,
      `value` text NOT NULL,
      `date_add` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY (`id`)
    ) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8");

    $this->db->query("
    CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "qf_label` (
      `id` int(11) NOT NULL AUTO_INCREMENT,
      `name` varchar(50) NOT NULL,
      `type` int(1) NOT NULL DEFAULT '1',
      `text` varchar(100) NOT NULL,
      `text_admin` varchar(100) NOT NULL,
      `placeholder` varchar(100) NOT NULL,
      `pattern` varchar(200) NOT NULL,
      `min` int(3) NOT NULL DEFAULT '-1',
      `max` int(3) NOT NULL DEFAULT '-1',
      `text_error` varchar(255) NOT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8");

    $this->db->query("
    CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "qf_label_to_form` (
      `id` int(11) NOT NULL AUTO_INCREMENT,
      `label_id` int(11) NOT NULL,
      `form_id` int(11) NOT NULL,
      `sort` int(11) NOT NULL DEFAULT '0',
      PRIMARY KEY (`id`)
    ) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8");
  }
  public function uninstall() {
    $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "qf`");
    $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "qf_content`");
    $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "qf_label`");
    $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "qf_label_to_form`");
  }
}
?>
