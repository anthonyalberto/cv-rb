$ ->
  sentences = [I18n.t('login.console1'), I18n.t('login.console2'), I18n.t('login.console3')]
  delay = 0
  for sentence in sentences
    console.log sentence == sentences[sentences.length - 1]
    delay = $("#intro_shell #command_input").typeline(sentence, delay: [30..90], totalDelay: delay + 150, carriageReturn: (if sentence == sentences[sentences.length - 1] then "false" else true))
