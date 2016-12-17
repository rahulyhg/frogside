<?php

namespace Frogside;

require_once __DIR__.'/../Controllers/AuthController.php';
require_once __DIR__.'/../Middleware/CorsMiddleware.php';

function initRoutes($app) {

  $app->group('/frogside', function(){

    $this->group('/v1', function(){

      $this->get('/tokens', AuthController::class.':login');

    });

    $this->options('/{routes:.+}', function ($req, $res) {
      return $res;
    });

  })->add( new CorsMiddleware() );

}
