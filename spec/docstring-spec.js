describe("Julia Tree-sitter docstrings", () => {
  let editor;

  beforeEach(async () => {
    lumine.config.set("editor.useTreeSitterParsers", true);
    await lumine.packages.activatePackage("language-julia");
    editor = await lumine.workspace.open("docstrings.jl");
    editor.setText(`"Function docs"
function function_name()
end
"Call docs"
target()`);
    await editor.getBuffer().languageMode.ready;
  });

  afterEach(() => editor.destroy());

  it("recognizes docstrings with leaf-rooted sibling checks", () => {
    const functionScopes = editor.scopeDescriptorForBufferPosition([0, 1]).getScopesArray();
    const callScopes = editor.scopeDescriptorForBufferPosition([3, 1]).getScopesArray();
    expect(functionScopes).toContain("string.quoted.docstring.julia");
    expect(callScopes).toContain("string.quoted.docstring.julia");
  });
});
