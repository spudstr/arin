<?php
$fp = STDIN;
while(!feof($fp))
{

        $string = trim(fgets($fp,1024000));
        if(empty($string)) break;
        $tmpPocLink = array();
        $xml_obj = simplexml_load_string($string, 'SimpleXMLElement', LIBXML_NOCDATA | LIBXML_NOBLANKS | LIBXML_NOEMPTYTAG);
        $xml_array=object2array($xml_obj);

        //if($xml_array["updateDate"]) $xml_array["updateDate"] = strtotime($xml_array["updateDate"]);

      //  if($xml_array["registrationDate"])  $xml_array["registrationDate"]  = strtotime($xml_array["registrationDate"]);

      //  if(!is_array($xml_array["pocLinks"])) break;
        foreach($xml_array["pocLinks"] as $poc)
        {
          // lets fix the pocLinks
          if(empty($poc)) break;
          foreach($poc as $pocDetail => $k)
          {
             foreach($k as $finalPoc => $z)
             {

                switch($z["description"])
                {
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
                }

             }
          }

        }
        unset($xml_array["ref"]);
      //print_r($tmpPocLink);
        if(!empty($xml_array["pocLinks"]["pocLink"] )) { $xml_array["pocLinks"]["pocLink"] = $tmpPocLink; }
        empty($tmpPocLink);
      //  print_r($xml_array["pocLinks"]);
        $js_obj = json_encode(json_decode(json_encode($xml_array),TRUE));
        echo "{$js_obj}\n";
}

function object2array($object) { return @json_decode(@json_encode($object),1); }
