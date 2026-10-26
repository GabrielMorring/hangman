module Dictionary
  def  self.random_word
    File.readlines("google-10000-english-no-swears.txt").sample.chomp.strip.downcase
  end
end
