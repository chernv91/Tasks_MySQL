<?php
require 'vendor/autoload.php';
$faker = Faker\Factory::create(ru_RU);
/*
$pattern = '/[\+\(\)\-\s]/';
$f = fopen('1.txt', 'w');
for($i = 0; $i < 1000; ++$i) {
    $phone = preg_replace($pattern, '', $faker->unique()->phoneNumber);
    if (strlen($phone) === 11) {
        fwrite($f, $phone ."\n");
    }*/

//}
/*

fclose($f);
*//*
$f1 = fopen('1.txt', 'w');
$f2 = fopen('2.txt', 'w');
$f3 = fopen('3.txt', 'w');
for($i = 0; $i < 10000; ++$i) {
    $name = explode(' ', $faker->name);
    fwrite($f1, $name[0] ."\n");
    fwrite($f2, $name[1] ."\n");
    fwrite($f3, $name[2] ."\n");
}

fclose($f1);
fclose($f2);
fclose($f3);
*/


$f1 = fopen('1.txt', 'w');

for($i = 0; $i < 10000; ++$i) {
    fwrite($f1,$faker->numberBetween(1,1000) ."\n");

}

fclose($f1);
