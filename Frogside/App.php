<?php

namespace Frogside;

require_once __DIR__.'/Routes/Routers.php';

function compile($viewPartial, $locals = array()){
  global $app;
  $viewName = $app->findView($viewPartial);
  $strloader = new \Twig_Loader_String();
  $fsloader = new \Twig_Loader_Filesystem($app->rootDir.'/views');
  $loader = new \Twig_Loader_Chain(array($fsloader,$strloader));
  $twig = new \Twig_Environment($loader);
  $parser = new \Mni\FrontYAML\Parser();
  $str = file_get_contents($viewName);
  $document = $parser->parse($str);
  if( is_array($document->getYAML()) ){
    $locals = array_merge($document->getYAML(),$locals);
  }
  $view_result = $twig->render($document->getContent(), $locals);
  $tmpl_result = $app->parseTemplate($twig, $locals);
  if( $tmpl_result ){
    $view_result = str_replace('<!-- yield -->', $view_result, $tmpl_result);
  }
  return $view_result;
}

class App {

  protected $app;
  public    $rootDir;

  public function parseTemplate($twig, $locals){
    $tmpl_name = $this->findTemplate($locals['template']);
    if( !file_exists($tmpl_name) ){
      return;
    }
    $tmpl_str = file_get_contents($tmpl_name);
    $parser = new \Mni\FrontYAML\Parser();
    $document = $parser->parse($tmpl_str);
    if( is_array($document->getYAML()) ){
      $locals = array_merge($document->getYAML(), $locals);
    }
    $template = $twig->render($document->getContent(), $locals);
    return $twig->render($document->getContent(), $locals);
  }

  public function findTemplate($partialName){
    return $this->rootDir.'/templates/'.$partialName.'.html';
  }

  public function findView($partialName){
    return $this->rootDir.'/views/'.$partialName.'.html';
  }

  public function __construct($rootDir) {
    $this->app = new \Slim\App;
    $this->rootDir = $rootDir;
    initRoutes($this->app);
  }

  public function run() {
    $this->app->run();
  }

  public function get($name, $fn) {
    $this->app->get($name,$fn);
  }

}
