<?php
class ControllerModuleQf extends Controller {
  private $error = array();
  private $html;
	public function index() {
    if(isset($this->request->get['fn']) && !empty($this->request->get['fn'])){
      $this->language->load('module/qf');
  		$this->load->model('module/qf');
      $this->data['form'] = $this->model_module_qf->getFormByName($this->request->get['fn']);
      $url = '';
      if(isset($this->request->get['pid']) && !empty($this->request->get['pid'])){
        $this->load->model('catalog/product');
        $url .= '&pid=' . $this->request->get['pid'];
        $this->data['product'] = $this->model_catalog_product->getProduct($this->request->get['pid']);
      }else{
        $this->data['product'] = false;
      }
      if($this->request->server['REQUEST_METHOD'] == 'POST'){
        if($this->validate($this->data['form'])){
          $data = $this->request->post;
          if(isset($this->request->get['pid']) && !empty($this->request->get['pid'])){
            $data['pid'] = $this->request->get['pid'];
          }

          $data['form_id'] = $this->data['form']['id'];
          //add to DB
          $this->model_module_qf->addContent($data);


          //send mail
          $mail = new Mail();
    			$mail->protocol = $this->config->get('config_mail_protocol');
    			$mail->parameter = $this->config->get('config_mail_parameter');
    			$mail->hostname = $this->config->get('config_smtp_host');
    			$mail->username = $this->config->get('config_smtp_username');
    			$mail->password = $this->config->get('config_smtp_password');
    			$mail->port = $this->config->get('config_smtp_port');
    			$mail->timeout = $this->config->get('config_smtp_timeout');
          $mail->setTo($this->config->get('config_email'));
  				$mail->setFrom($this->config->get('config_email'));
  	  		$mail->setSender('QUICK|FORM');
  	  		$mail->setSubject($this->data['form']['name'], ENT_QUOTES, 'UTF-8');
          $mail->setHtml($this->html);
  	  		// $mail->setText(strip_tags(html_entity_decode($this->request->post['enquiry'], ENT_QUOTES, 'UTF-8')));
      		$mail->send();

          $this->data['success'] = $this->data['form']['success'];

        }else{
          foreach($this->data['form']['labels'] as $key => $label){
            if(isset($this->request->post[$key])){
              $this->data['form']['labels'][$key]['value'] = trim($this->request->post[$key]);
            }else{
              $this->data['form']['labels'][$key]['value'] = '';
            }

            if(isset($this->error[$key])){
              $this->data['error_' . $key] = $this->error[$key];
            }
          }
          if(isset($this->error['error_not_label'])){
            $this->data['error_not_label'] = $this->error['not_label'];
          }
        }
      }

      $this->data['button_submit'] = $this->language->get('button_submit');

      if(isset($this->request->get['popup']) && (int)$this->request->get['popup']==1){
        $this->data['popup'] = true;
        $url .='&popup=1';
      }else{
        $this->data['popup'] = false;
      }

      $this->data['action'] = $this->url->link('module/qf', 'fn=' . $this->request->get['fn'] . $url, 'SSL');

  		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/qf.tpl')) {
  			$this->template = $this->config->get('config_template') . '/template/module/qf.tpl';
  		} else {
  			$this->template = 'default/template/module/qf.tpl';
  		}

  		$this->response->setOutput($this->render());
    }else{
      $this->response->setOutput('');
    }
	}

  private function validate($form) {
    if(!empty($this->request->post)){
      $this->html = '<table>';
      if(isset($this->request->get['pid'])){
        $this->html .= '<tr><td>' . $this->language->get('text_id') . ':</td><td>' . (int)$this->request->get['pid'] . '</td></tr>';
      }
      foreach($form['labels'] as $key => $label){
        switch((int)$label['type']){
          //input, textarea
          case 1:
          case 3:
            if(isset($this->request->post[$key])){
              if($label['min'] != '-1' && mb_strlen(trim($this->request->post[$key]), 'UTF-8') < (int)$label['min'] ||
                 $label['max'] != '-1' && mb_strlen(trim($this->request->post[$key]), 'UTF-8') > (int)$label['max'] ||
                 !empty($label['pattern']) && !preg_match($label['pattern'], trim($this->request->post[$key]))){
                $this->error[$key] = $label['text_error'];
              }
            }else{
              if($label['min'] != '-1' || $label['max'] != '-1' || !empty($label['pattern'])){
                $this->error[$key] = $label['text_error'];
              }
            }
          break;
          //checkbox
          case 2:
            if(isset($this->request->post[$key])){
              if($label['min'] != '-1' && $this->request->post[$key] != 1){
                $this->error[$key] = $label['text_error'];
              }
            }else{
              if($label['min'] != '-1'){
                $this->error[$key] = $label['text_error'];
              }else{
                $this->request->post[$key] = 0;
              }
            }
          break;
        }
        $this->html .= '<tr><td>' . $label['text_admin'] . ':</td><td>' . $this->request->post[$key] . '</td></tr>';
      }
      $this->html = '</table>';

      if(empty($this->error)){
        return true;
      }else{
        return false;
      }
    }else{
      $this->error['not_label'] = $this->language->get('error_not_label');
      return false;
    }
  }
}
?>
