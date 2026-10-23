describe("Julia upstream structural queries", () => {
  let editor;

  beforeEach(async () => {
    for (const name of ["language-gfm", "language-regex", "language-shellscript", "language-julia"])
      await lumine.packages.activatePackage(name);
    editor = await lumine.workspace.open("structure.jl");
    editor.setTabLength(2);
  });

  afterEach(() => editor.destroy());

  it("folds and indents unindented blocks including branch bodies", async () => {
    editor.setText("function greet(name)\nif name\nreturn name\nelse\nreturn nothing\nend\nend");
    expect(await editor.whenGrammarSettled()).toBe(true);
    expect(editor.languageMode.tree.rootNode.hasError).toBe(false);
    expect(editor.isFoldableAtBufferRow(0)).toBe(true);
    await editor.autoIndentBufferRows(0, 6);
    expect([1, 2, 3, 4, 5, 6].map((row) => editor.indentationForBufferRow(row))).toEqual([
      1, 2, 1, 2, 1, 0,
    ]);
  });

  it("injects docstrings, explicit markdown, regex and commands without ordinary strings", async () => {
    editor.setText(
      '"""**Function docs**"""\nfunction greet()\nend\npattern = r"[a-z]+"\nreadme = md"**Hello**"\ncmd = `echo hello`\nplain = "[ordinary]"\n',
    );
    expect(await editor.whenGrammarSettled()).toBe(true);
    const scopes = (row, col) =>
      editor.scopeDescriptorForBufferPosition([row, col]).getScopesArray();
    expect(scopes(0, 6)).toContain("source.gfm");
    expect(scopes(3, 14)).toContain("source.regexp");
    expect(scopes(4, 15)).toContain("source.gfm");
    expect(scopes(5, 8)).toContain("source.shell");
    expect(scopes(6, 11)).not.toContain("source.regexp");
    expect(scopes(6, 11)).not.toContain("source.gfm");
  });

  it("keeps Julia interpolation outside shell content", async () => {
    editor.setText("cmd = `echo $name`\n");
    expect(await editor.whenGrammarSettled()).toBe(true);
    expect(editor.scopeDescriptorForBufferPosition([0, 8]).getScopesArray()).toContain(
      "source.shell",
    );
    expect(editor.scopeDescriptorForBufferPosition([0, 13]).getScopesArray()).not.toContain(
      "source.shell",
    );
  });
});
