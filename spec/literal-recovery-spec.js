describe("Literal recovery in julia", () => {
  let editor;
  beforeEach(async () => {
    await lumine.packages.activatePackage("language-julia");
    editor = await lumine.workspace.open();
    editor.setGrammar(lumine.grammars.grammarForScopeName("source.julia"));
    editor.update({ tabLength: 4, softTabs: true });
    await editor.whenGrammarSettled();
  });
  afterEach(() => editor?.destroy());

  async function enterAfter(source, columns) {
    editor.setText(source);
    await editor.whenGrammarSettled();
    const row = editor.getLastBufferRow();
    editor.setCursorBufferPosition([row, Infinity]);
    editor.insertText("\n", { autoIndent: true, autoIndentNewline: true });
    await editor.whenGrammarSettled();
    expect(editor.lineTextForBufferRow(row + 1))
      .withContext(source)
      .toBe(" ".repeat(columns));
    expect(editor.getCursorBufferPosition().column).withContext(source).toBe(columns);
  }

  for (const [source, columns] of [
    ['value = "{', 0],
    ['value = raw"{', 0],
    ['value = r"{', 0],
    ["value = `echo {", 0],
    ['function f()\n    value = "{', 4],
  ]) {
    it("keeps the literal margin for " + JSON.stringify(source), async () => {
      await enterAfter(source, columns);
    });
  }

  for (const source of [
    "values = [",
    'value = "text"; values = [',
    "value = `echo text`; values = [",
  ]) {
    it("still indents a real container in " + JSON.stringify(source), async () => {
      await enterAfter(source, 4);
    });
  }
});
