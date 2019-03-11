<?php
namespace App;

class ConfigurationUtils {
    public static function ReadEmailSection($sectionName) {
        $config = file_get_contents("data/content_en.json");
        return json_decode($config, true)['email'][$sectionName];
    }
}