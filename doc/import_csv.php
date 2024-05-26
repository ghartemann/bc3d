<?php

$files = scandir('csv');

foreach ($files as $file) {
    if ($file === 'bps-convertcsv.csv' && ($handle = fopen("csv/" . $file, "r")) !== FALSE) {
        $csvs = [];

        while (!feof($handle)) {
            $parsedCsv[] = fgetcsv($handle, separator: ';');
        }

        $datas = [];
        $column_names = [];

        // column names
        foreach ($parsedCsv[0] as $col) {
            $columnNames[] = $col;
        }

        // data
        foreach ($parsedCsv as $key => $data) {
            if ($key === 0) {
                continue;
            }

            foreach ($columnNames as $colKey => $colName) {
                if ($colName === null || $colName === '' || ($colName !== null && str_contains($colName, 'ignore'))) {
                    continue;
                }

                if (str_contains($colName, '/')) {
                    $test_name = explode('/', $colName);

                    $datas[$key - 1][$test_name[0]][$test_name[1]] = $data[$colKey];
                } else {
                    $datas[$key - 1][$colName] = $data[$colKey];
                }
            }
        }

        $json = json_encode($datas);

        fclose($handle);
        print_r($file);
        file_put_contents('json/' . str_replace('.csv', '.json', $file), $json);
    }
}
