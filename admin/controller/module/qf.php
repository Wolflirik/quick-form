<?php
class ControllerModuleQf extends Controller {
  private $error;
  private $json = array();

  public function install() {
    $this->load->model('module/qf');
    $this->model_module_qf->install();
  }
  public function uninstall() {
    $this->load->model('module/qf');
    $this->model_module_qf->uninstall();
  }

  public function index() {
    $this->main();

    $this->data['page'] = $this->url->link('module/qf', 'token=' . $this->session->data['token'], 'SSL');
    $this->data['text_form_name'] = $this->language->get('text_form_name');
    $this->data['text_form_config'] = $this->language->get('text_form_config');
    $this->data['text_form_class'] = $this->language->get('text_form_class');
    $this->data['text_form_before'] = $this->language->get('text_form_before');
    $this->data['text_form_after'] = $this->language->get('text_form_after');
    $this->data['text_form_set_label'] = $this->language->get('text_form_set_label');
    $this->data['text_form_label_name'] = $this->language->get('text_form_label_name');
    $this->data['text_form_label_sort'] = $this->language->get('text_form_label_sort');
    $this->data['text_form_yandex'] = $this->language->get('text_form_yandex');
    $this->data['text_form_success'] = $this->language->get('text_form_success');
    $this->data['text_form_add'] = $this->language->get('text_form_add');
    $this->data['text_form_add_label'] = $this->language->get('text_form_add_label');
    $this->data['text_form_label_name'] = $this->language->get('text_form_label_name');
    $this->data['text_form_label_sort'] = $this->language->get('text_form_label_sort');
    $this->data['text_form_id'] = $this->language->get('text_form_id');
    $this->data['text_form_labels_warning'] = $this->language->get('text_form_labels_warning');
    $this->data['text_form_change_warning'] = $this->language->get('text_form_change_warning');
    $this->data['text_form_ident_error'] = $this->language->get('text_form_ident_error');
    $this->data['text_form_label_set'] = $this->language->get('text_form_label_set');

    $this->data['forms'] = $this->model_module_qf->getForms();

    $this->data['labels'] = $this->model_module_qf->getLabels();

    $this->template = 'module/qf/form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
  }

  public function createForm() {
    $this->load->model('module/qf');
    $id = $this->model_module_qf->createForm();
    $this->json['success'] = array(
      'id' => $id,
      'link' => $this->url->link('module/qf/tabContent', 'token=' . $this->session->data['token'] . '&f_id=' . $id, 'SSL')
    );

    $this->response->setOutput(json_encode($this->json));
  }

  public function deleteForm() {
    if($this->request->server['REQUEST_METHOD'] == 'POST'){
      $this->load->language('module/qf');
      if (isset($this->request->post['id']) && !empty($this->request->post['id'])) {
        $this->load->model('module/qf');
        $this->json['success'] = array(
          'id' => $this->model_module_qf->deleteForm($this->request->post)
        );
      }else{
        $this->json['error'] = $this->language->get('text_form_error_delete');
      }
    }

    $this->response->setOutput(json_encode($this->json));
  }

  public function updateForm() {
    if (($this->request->server['REQUEST_METHOD'] == 'POST') ) {
      $this->load->model('module/qf');
      if($this->validate('form')){
        if($this->model_module_qf->updateForm($this->request->post)){
          $this->json['success'] = true;
        }else{
          $this->json['error'] = 'sql';
        }
      }else{
        $this->json['error'] = $this->error;
      }
    }

    $this->response->setOutput(json_encode($this->json));
  }

  public function label() {
    $this->main();

    $this->data['page'] = $this->url->link('module/qf/label', 'token=' . $this->session->data['token'], 'SSL');
    $this->data['text_label_add'] = $this->language->get('text_label_add');
    $this->data['text_label_add_type_1'] = $this->language->get('text_label_add_type_1');
    $this->data['text_label_add_type_2'] = $this->language->get('text_label_add_type_2');
    $this->data['text_label_add_type_3'] = $this->language->get('text_label_add_type_3');
    $this->data['text_label_name'] = $this->language->get('text_label_name');
    $this->data['text_label_text_catalog'] = $this->language->get('text_label_text_catalog');
    $this->data['text_label_text_admin'] = $this->language->get('text_label_text_admin');
    $this->data['text_label_placeholder'] = $this->language->get('text_label_placeholder');
    $this->data['text_label_pattern'] = $this->language->get('text_label_pattern');
    $this->data['text_label_min'] = $this->language->get('text_label_min');
    $this->data['text_label_max'] = $this->language->get('text_label_max');
    $this->data['text_label_error_text'] = $this->language->get('text_label_error_text');
    $this->data['text_label_error'] = $this->language->get('text_label_error');
    $this->data['text_label_col_name'] = $this->language->get('text_label_col_name');
    $this->data['text_label_col_text_catalog'] = $this->language->get('text_label_col_text_catalog');
    $this->data['text_label_col_text_admin'] = $this->language->get('text_label_col_text_admin');
    $this->data['text_label_col_placeholder'] = $this->language->get('text_label_col_placeholder');
    $this->data['text_label_col_pattern'] = $this->language->get('text_label_col_pattern');
    $this->data['text_label_col_min'] = $this->language->get('text_label_col_min');
    $this->data['text_label_col_max'] = $this->language->get('text_label_col_max');
    $this->data['text_label_col_error_text'] = $this->language->get('text_label_col_error_text');
    $this->data['text_label_col_type'] = $this->language->get('text_label_col_type');
    $this->data['text_label_checkbox_min'] = $this->language->get('text_label_checkbox_min');
    $this->data['text_label_checkbox_error_text'] = $this->language->get('text_label_checkbox_error_text');
    $this->data['text_label_warning_tie'] = $this->language->get('text_label_warning_tie');

    $this->data['labels'] = $this->model_module_qf->getLabels();

    $this->template = 'module/qf/label.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
  }

  public function createLabel() {
    if ($this->request->server['REQUEST_METHOD'] == 'POST'){
      $this->load->model('module/qf');

      $data = $this->model_module_qf->createLabel($this->request->post);
      $this->json['success'] = $data;
    }

    $this->response->setOutput(json_encode($this->json));
  }

  public function checkTie() {
    if ($this->request->server['REQUEST_METHOD'] == 'POST' && isset($this->request->post['id']) && !empty($this->request->post['id'])){
      $this->load->model('module/qf');
      $this->json['success'] = array(
        'tie' => $this->model_module_qf->checkTieLabel($this->request->post)?'to_tie':'not_tie'
      );
    }

    $this->response->setOutput(json_encode($this->json));
  }

  public function deleteLabel() {
    if ($this->request->server['REQUEST_METHOD'] == 'POST'){
      $this->load->language('module/qf');
      $this->load->model('module/qf');
      if(isset($this->request->post['id']) && !empty($this->request->post['id'])){
        $this->json['success'] = array(
          'id' => $this->model_module_qf->deleteLabel($this->request->post)
        );
      }else{
        $this->json['error'] = $this->language->get('text_label_error_delete');
      }
    }

    $this->response->setOutput(json_encode($this->json));
  }

  public function updateLabel() {
    if (($this->request->server['REQUEST_METHOD'] == 'POST') ) {
      $this->load->model('module/qf');
      if($this->validate('label')){
        if($this->model_module_qf->updateLabel($this->request->post)){
          $this->json['success'] = true;
        }else{
          $this->json['error'] = 'sql';
        }
      }else{
        $this->json['error'] = $this->error;
      }
    }

    $this->response->setOutput(json_encode($this->json));
  }

  public function tabContent() {

    if(!isset($this->request->get['f_id']) || (isset($this->request->get['f_id']) && empty($this->request->get['f_id']))){
      $this->redirect($this->url->link('module/qf', 'token=' . $this->session->data['token'], 'SSL'));
    }

    $this->main();

    $this->data['form'] = $this->model_module_qf->getFormById($this->request->get['f_id']);
    if(!$this->data['form']){
      $this->redirect($this->url->link('module/qf', 'token=' . $this->session->data['token'], 'SSL'));
    }

    $this->data['page'] = $this->url->link('module/qf/tabContent', 'f_id=' . $this->request->get['f_id'] . '&token=' . $this->session->data['token'], 'SSL');

    $url = '&f_id=' . $this->request->get['f_id'];

    if(isset($this->request->get['page'])){
      $url .= '&page=' . $this->request->get['page'];
      $page = $this->request->get['page'];
    }else{
      $page = 1;
    }

    $data = array(
      'f_id'            => $this->request->get['f_id'],
      'start'           => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit'           => $this->config->get('config_admin_limit')
    );

    $content_total = $this->model_module_qf->getContentTotal($data);
    $this->data['contents'] = $this->model_module_qf->getContent($data);
    $this->data['text_product_id'] = $this->language->get('text_product_id');
    $this->data['product_link'] = str_replace('/admin', '', $this->url->link('product/product', '', 'SSL'));

    $pagination = new Pagination();
		$pagination->total = $content_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('module/qf/tabContent', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

    $this->data['pagination'] = $pagination->render();

    $this->template = 'module/qf/content.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
  }

  public function deleteContent() {
    $this->load->language('module/qf');
    if ($this->request->server['REQUEST_METHOD'] == 'POST' && (isset($this->request->post['id']) && !empty($this->request->post['id']))) {
      $this->load->model('module/qf');
      $this->json['success'] = array(
        'id' => $this->model_module_qf->deleteContent($this->request->post)
      );
    }else{
      $this->json['error'] = $this->language->get('text_content_error');
    }

    $this->response->setOutput(json_encode($this->json));
  }

  private function validate($context = '') {
    $this->load->language('module/qf');
    switch($context){
      case 'form':
        if(empty($this->request->post['name']) || empty($this->request->post['class'])){
          $this->error = $this->language->get('text_form_error');
          return false;
        }
      break;
      case 'label':
        if((!isset($this->request->post['name']) || isset($this->request->post['name']) && empty($this->request->post['name']))
          || (!isset($this->request->post['text_admin']) || isset($this->request->post['text_admin']) && empty($this->request->post['text_admin']))){
          $this->error = $this->language->get('text_label_error');
          return false;
        }
        if($this->model_module_qf->checkUniqueLabelName($this->request->post)){
          $this->error = $this->language->get('text_label_error_unique_name');
          return false;
        }
      break;
      default:
        return false;
    }
    return true;
  }

  private function main() {
    $this->load->language('module/qf');
    $this->load->model('module/qf');

    $this->document->setTitle($this->language->get('heading_title'));
    $this->document->addScript('https://kit.fontawesome.com/f4f05b5355.js');
    $this->document->addStyle('view/stylesheet/qf.css');

    $this->data['heading_title'] = $this->language->get('heading_title');
    $this->data['token'] =  $this->session->data['token'];

    $this->data['breadcrumbs'] = array();

    $this->data['breadcrumbs'][] = array(
        'text'      => $this->language->get('text_home'),
        'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
        'separator' => false
    );

    $this->data['breadcrumbs'][] = array(
        'text'      => $this->language->get('text_module'),
        'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
        'separator' => ' :: '
    );

    $this->data['breadcrumbs'][] = array(
        'text'      => $this->language->get('heading_title'),
        'href'      => $this->url->link('module/qf', 'token=' . $this->session->data['token'], 'SSL'),
        'separator' => ' :: '
    );

    $this->data['btn_cancel'] = $this->language->get('btn_cancel');
    $this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

    // $this->data['tabs']
    $contentTabs = $this->model_module_qf->getTabs();

    $this->data['tabs'] = array();
    $this->data['tabs'][0] = array(
      'name' => $this->language->get('tab_0'),
      'id' => false,
      'link' => $this->url->link('module/qf', 'token=' . $this->session->data['token'], 'SSL')
    );

    $this->data['tabs'][1] = array(
      'name' => $this->language->get('tab_1'),
      'id' => false,
      'link' => $this->data['tabs'][1] = $this->url->link('module/qf/label', 'token=' . $this->session->data['token'], 'SSL')
    );

    foreach($contentTabs as $tab) {
      $this->data['tabs'][] = array(
        'name' => $tab['name'],
        'id' => $tab['id'],
        'link' => $this->url->link('module/qf/tabContent', 'f_id=' . $tab['id'] . '&token=' . $this->session->data['token'], 'SSL')
      );
    }

    $this->data['btn_delete'] = $this->language->get('btn_delete');
    $this->data['btn_save'] = $this->language->get('btn_save');
    $this->data['btn_minus'] = $this->language->get('btn_minus');
    $this->data['btn_plus'] = $this->language->get('btn_plus');
    $this->data['text_select'] = $this->language->get('text_select');
    $this->data['btn_refresh'] = $this->language->get('btn_refresh');
  }
}


?>
