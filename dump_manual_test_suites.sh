#!/usr/bin/bash


OUTPUT_DIR=~/manual_test_suites
rm "$OUTPUT_DIR" -rf

query() {
	psql -U qatracker qatracker --csv -c "$1 ;"
}

map_testcase_status_to_string() {
	case $1 in
		"0")
			echo "Mandatory"
			;;
		"1")
			echo "Disabled"
			;;
		"2")
			echo "Run-Once"
			;;
		"3")
			echo "Optional"
			;;
	esac
}

for series in "Resolute" "Noble"; do
	output_dir="$OUTPUT_DIR/$series"
	echo "Dumping manual tests for $series in $output_dir"
	milestone_series_id=$(query "SELECT id FROM qatracker_milestone_series WHERE title='$series'" | tail -n +2)
	echo "milestone series id: $milestone_series_id"
	testsuite_product_mapping="$(query "SELECT * FROM qatracker_testsuite_product WHERE milestone_seriesid=$milestone_series_id" | tail -n +2)"
	for mapping in $testsuite_product_mapping; do
		###################
		### Test suites ###
		###################
		testsuite_id="$(echo "$mapping" | cut -d',' -f 1)"
		testsuite_name="$(query "SELECT title FROM qatracker_testsuite WHERE id=$testsuite_id" | tail -n +2)"
		testsuite_output_folder="$output_dir/testsuites/$testsuite_name"
		if [ -d "$testsuite_output_folder" ]; then
			echo "Skipping testsuite $testsuite_name, already done"
		else
			echo "Dumping testsuite $testsuite_name"
			for testcase_id in $(query "SELECT testcaseid FROM qatracker_testsuite_testcase WHERE testsuiteid=$testsuite_id" | tail -n +2); do
				testcase_name="$(query "SELECT title FROM qatracker_testcase WHERE id=$testcase_id" | tail -n +2 | tr "/" "_")"
				testcase_content="$(query "SELECT text FROM qatracker_testcase_revision WHERE testcaseid=$testcase_id ORDER BY id DESC LIMIT 1" | tail -n +2)"
				testcase_status="$(map_testcase_status_to_string "$(query "SELECT status FROM qatracker_testsuite_testcase WHERE testsuiteid=$testsuite_id AND testcaseid=$testcase_id LIMIT 1" | tail -n +2)")"
				testcase_output_folder="$testsuite_output_folder/$testcase_status"
				mkdir -p "$testcase_output_folder"
				testcase_output="$testcase_output_folder/$testcase_name.html"
				# yes, dos2unix is needed for some entries in there 😭
				echo "$testcase_content" \
				   | dos2unix \
				   > "$testcase_output"
			done
		fi

		################
		### Products ###
		################
		product_id="$(echo "$mapping" | cut -d',' -f 3)"
		product_name="$(query "SELECT title FROM qatracker_product WHERE id=$product_id" | tail -n +2)"
		product_output_folder="$output_dir/products/$product_name"
		echo "Dumping product $product_name"
		mkdir -p "$product_output_folder"

		####################################
		### Products/Test suites mapping ###
		####################################
		echo "Mapping $testsuite_name to $product_name"
		pushd "$product_output_folder"
		ln -s "$(realpath --relative-to . "$testsuite_output_folder")"
		popd
	done
done
