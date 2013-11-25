render 'pdf/font', pdf: pdf

base_size ||= 11

pdf.font 'PT', size: base_size, style: :bold, align: :center do
  pdf.text 'МИНИСТЕРСТВО ОБРАЗОВАНИЯ И НАУКИ РОССИЙСКОЙ ФЕДЕРАЦИИ', align: :center
  pdf.text 'федеральное государственное бюджетное образовательное', align: :center
  pdf.text 'учреждение высшего профессионального образования', align: :center
  pdf.text '«МОСКОВСКИЙ ГОСУДАРСТВЕННЫЙ УНИВЕРСИТЕТ ПЕЧАТИ ИМЕНИ ИВАНА ФЕДОРОВА»', align: :center
end

pdf.line_width = 2
pdf.stroke do
  pdf.move_down 3
  pdf.horizontal_rule
end

pdf.line_width = 0.5
pdf.stroke do
  pdf.move_down 2
  pdf.horizontal_rule
end
pdf.move_down 13

pdf.text title, size: (base_size + 3), style: :bold, align: :center
pdf.move_down 13
