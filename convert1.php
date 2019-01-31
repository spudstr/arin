<?php
$fp = STDIN;
while (!feof($fp)) {
    $string = trim(fgets($fp, 1024000));
    if (empty($string)) {
        break;
    }
    $tmpPocLink = array();
    $xml_obj = simplexml_load_string($string, 'SimpleXMLElement', LIBXML_NOCDATA | LIBXML_NOBLANKS | LIBXML_NOEMPTYTAG);
    $xml_array=object2array($xml_obj);

    //if($xml_array["updateDate"]) $xml_array["updateDate"] = strtotime($xml_array["updateDate"]);

    //  if($xml_array["registrationDate"])  $xml_array["registrationDate"]  = strtotime($xml_array["registrationDate"]);

    //  if(!is_array($xml_array["pocLinks"])) break;
    //  echo sizeof($xml_array["pocLinks"])."\n";

  //  echo sizeof($xml_array["pocLinks"])."\n";
  //  print_r($xml_array["pocLinks"]);
    if (sizeof($xml_array["pocLinks"]) > 0) {
        //    echo sizeof($xml_array["pocLinks"])."\n";
        foreach ($xml_array["pocLinks"] as $poc) {
            if (sizeof($poc) == 1) {
              foreach($poc as $pocDetail => $k)
              {
              //  print_r($k);
              switch ($k["description"]) {
              case "Abuse":
              $tmpPocLink["Abuse"]["handle"] = $k["handle"];
              $tmpPocLink["Abuse"]["function"] = $k["function"];
              break;
              case "Admin":
              $tmpPocLink["Admin"]["handle"] = $k["handle"];
              $tmpPocLink["Admin"]["function"] = $k["function"];
              break;
              case "Tech":
              $tmpPocLink["Tech"]["handle"] = $k["handle"];
              $tmpPocLink["Tech"]["function"] = $k["function"];
              break;
              case "NOC":
              $tmpPocLink["NOC"]["handle"] = $k["handle"];
              $tmpPocLink["NOC"]["function"] = $k["function"];
              break;
            }
          }

            } else {
                // lets fix the pocLinks
                foreach ($poc as $pocDetail => $k) {
                    //  print_r($z)
                    foreach ($k as $finalPoc => $z) {
                    switch ($z["description"]) {
                    case "Abuse":
                    $tmpPocLink["Abuse"]["handle"] = $z["handle"];
                    $tmpPocLink["Abuse"]["function"] = $z["function"];
                    break;
                    case "Admin":
                    $tmpPocLink["Admin"]["handle"] = $z["handle"];
                    $tmpPocLink["Admin"]["function"] = $z["function"];
                    break;
                    case "Tech":
                    $tmpPocLink["Tech"]["handle"] = $z["handle"];
                    $tmpPocLink["Tech"]["function"] = $z["function"];
                    break;
                    case "NOC":
                    $tmpPocLink["NOC"]["handle"] = $z["handle"];
                    $tmpPocLink["NOC"]["function"] = $z["function"];
                    break;
                }
                    }
                }
            }
        }
    }
    unset($xml_array["ref"]);
    //print_r($tmpPocLink);
    if (!empty($xml_array["pocLinks"]["pocLink"])) {
        $xml_array["pocLinks"]["pocLink"] = $tmpPocLink;
    }
    empty($tmpPocLink);
    //  print_r($xml_array["pocLinks"]);
    $js_obj = json_encode(json_decode(json_encode($xml_array), true));
    echo "{$js_obj}\n";
}

function object2array($object)
{
    return @json_decode(@json_encode($object), 1);
}
