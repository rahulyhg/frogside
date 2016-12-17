<?php

namespace Frogside;

class AuthController {

   public function login($req, $res) {
     return $res->write('test');
   }

}
