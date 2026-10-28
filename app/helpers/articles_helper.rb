module ArticlesHelper
  def article_body(article)
    blocks = []
    code = nil
    part = 0

    article.body.each_line do |line|
      if line.start_with?("```")
        if code
          blocks << tag.pre(tag.code(code.join), class: "code-block")
          code = nil
        else
          code = []
        end
      elsif code
        code << line
      elsif line.start_with?("## ")
        part += 1
        blocks << tag.h2(line.delete_prefix("## ").strip, id: "part-#{part}")
      elsif line.strip.present?
        blocks << tag.p(line.strip)
      end
    end

    safe_join(blocks)
  end

  def article_card_size(index)
    [ 0, 5 ].include?(index % 6) ? "wide" : "narrow"
  end
end
