require 'random-word'
class QuestionData
  def self.question
    return {
          :text => RandomWord.adjs.next,
          :answers => {
              "answer_0" => {
                  "answer_weight" => 100,
                  "answer_text" => RandomWord.adjs.next
              },

              "answer_1" => {
                  "answer_weight" => 0,
                  "answer_text" => RandomWord.adjs.next
              }
          }
    }
  end
end