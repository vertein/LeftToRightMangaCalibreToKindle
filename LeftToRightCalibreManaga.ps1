$metadata_line = '<metadata(.*?)>'
$new_meta_line = '    <meta name="primary-writing-mode" content="vertical-rl" />'
$new_css_line = 'html,
.hltr {
-webkit-writing-mode: horizontal-tb;
-webkit-writing-mode: horizontal-tb;
}
.vrtl {
-webkit-writing-mode: vertical-rl;
-webkit-writing-mode: vertical-rl;
}'
$old_spine_line = '<spine(.*?)>'
$new_spine_line = '<spine page-progression-direction="rtl" toc="ncx">'
$new_itemref_line = '    <itemref idref="x_p-cover" linear="no" properties="page-spread-left"/>'

Get-ChildItem -Recurse -Include "*.opf" |
    ForEach-Object { 
        (Get-Content $_) -replace $metadata_line, "$&`n$new_meta_line" | Set-Content $_ 
    }

Get-ChildItem -Recurse -Include "*.css" |
    ForEach-Object { Add-Content $_ "`n$new_css_line" }

Get-ChildItem -Recurse -Include "*.opf" |
    ForEach-Object { (Get-Content $_) -replace $old_spine_line, "$new_spine_line`n$new_itemref_line" | Set-Content $_ }
    