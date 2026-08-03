# Assertions live in the comments: `<- scope` checks the marker's own column
# on the previous non-comment line, `^ scope` checks the caret's. Scopes
# match by prefix, so the trailing `.julia` segment is left off.

function scale(v, n)
# <- storage.type.function
#             ^ punctuation.definition.arguments.begin.bracket.round
#               ^ punctuation.separator.comma

    x = 1
#       ^ constant.numeric

end
# <- storage.type.function

# a comment
# <- comment
