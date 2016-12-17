<?php
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

require 'vendor/autoload.php';
require __DIR__.'/../Frogside/App.php';

$app = new \Frogside\App(__DIR__);

$app->get('/', function($req, $res){
  $locals = array(title => 'test');
  $str = \Frogside\compile('index', $locals);
  return $res->write($str);
});

$app->run();
