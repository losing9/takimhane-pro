<?php

use App\Models\Tool;

$tools = Tool::all();
$count = 0;

foreach ($tools as $tool) {
    if (!empty($tool->serial_number)) {
        $tool->barcode = $tool->serial_number;
        $tool->save();
        $count++;
    }
}

echo "Updated $count tools.";
