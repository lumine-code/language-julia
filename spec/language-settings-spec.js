describe("language-julia editing defaults", () => {
  let editor;
  beforeEach(async () => {
    jasmine.useRealClock();
    await lumine.packages.activatePackage("language-source");
    await lumine.packages.activatePackage("language-julia");
    await lumine.packages.activatePackage("bracket-matcher");
    editor = await lumine.workspace.open();
    editor.setGrammar(lumine.grammars.grammarForScopeName("source.julia"));
    editor.setText("push!(items, value)");
    await editor.whenGrammarSettled();
  });
  afterEach(() => editor?.destroy());

  it("uses the correct comment operation in source.julia", async () => {
    editor.setGrammar(lumine.grammars.grammarForScopeName("source.julia"));
    editor.setText("push!(items, value)");
    await editor.whenGrammarSettled();
    await editor.toggleLineCommentsForBufferRows(0, editor.getLastBufferRow());
    await editor.whenGrammarSettled();
    expect(editor.lineTextForBufferRow(0)).toBe("# push!(items, value)");
    await editor.toggleLineCommentsForBufferRows(0, editor.getLastBufferRow());
    await editor.whenGrammarSettled();
    expect(editor.getText()).toBe("push!(items, value)");
  });

  it("provides real block delimiters to snippet and comment consumers", async () => {
    const delimiters = await editor.getCommentDelimitersForBufferPosition([0, 0]);
    expect(delimiters.block).toEqual(["#=", "=#"]);
    expect(delimiters.line).toBe("#");
  });

  it("selects a complete language identifier without including adjacent syntax", () => {
    const index = editor.getText().indexOf("push!");
    editor.setCursorBufferPosition(editor.getBuffer().positionForCharacterIndex(index + 2));
    editor.selectWordsContainingCursors();
    expect(editor.getSelectedText()).toBe("push!");
  });
  it("keeps explicit user word-boundary overrides", () => {
    const options = { scopeSelector: ".source.julia" };
    try {
      lumine.config.set("editor.nonWordCharacters", "!", options);
      const index = editor.getText().indexOf("push!");
      editor.setCursorBufferPosition(editor.getBuffer().positionForCharacterIndex(index + 2));
      editor.selectWordsContainingCursors();
      expect(editor.getSelectedText()).not.toBe("push!");
    } finally {
      lumine.config.unset("editor.nonWordCharacters", options);
    }
  });

  it("does not insert a second apostrophe for an operator or unpaired token", async () => {
    editor.setText("[1, 2]");
    await editor.whenGrammarSettled();
    editor.setCursorBufferPosition([0, Infinity]);
    await editor.insertText("'");
    await editor.whenGrammarSettled();
    expect(editor.getText()).toBe("[1, 2]'");
  });
  it("still pairs a clear opening parenthesis and honors user quote pairs", async () => {
    editor.setText("");
    await editor.whenGrammarSettled();
    await editor.insertText("(");
    await editor.whenGrammarSettled();
    expect(editor.getText()).toBe("()");
    const options = { scopeSelector: ".source.julia" };
    try {
      lumine.config.set("bracket-matcher.autocompleteCharacters", ["''"], options);
      lumine.config.set("bracket-matcher.autocompleteDisabledCharacters", [], options);
      editor.setText("");
      await editor.whenGrammarSettled();
      editor.setCursorBufferPosition([0, 0]);
      await editor.insertText("'");
      await editor.whenGrammarSettled();
      expect(editor.getText()).toBe("''");
    } finally {
      lumine.config.unset("bracket-matcher.autocompleteCharacters", options);
      lumine.config.unset("bracket-matcher.autocompleteDisabledCharacters", options);
    }
  });

  it("selects an extensionless executable from an exact interpreter shebang", () => {
    for (const text of [
      "#!/usr/bin/env julia.exe",
      "#!/julia/bin/julia.exe",
      "#!C:\\julia\\bin\\julia.exe",
      "#!/usr/bin/env.exe -S julia.exe --version",

      "#!/usr/bin/julia",
      "#!/usr/bin/env julia\n",
      "#!/usr/bin/env -S julia --version\n",
    ]) {
      expect(lumine.grammars.selectGrammar("executable", text).scopeName).toBe("source.julia");
    }
    for (const text of [
      "#!/usr/bin/not-julia",
      "#!/usr/bin/env julia-wrapper",
      "#!/usr/bin/env julia.exe-wrapper",
      "some julia prose",
    ]) {
      expect(lumine.grammars.selectGrammar("executable", text).scopeName).not.toBe("source.julia");
    }
  });
});
