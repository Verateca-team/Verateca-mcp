# Verateca MCP

**The practical guide to supplements, for AI assistants.**

Verateca is a remote MCP server that answers everyday questions about dietary supplements with published data, sources and check dates:

- What does this product's label contain?
- Does the same ingredient add up too high across several products?
- How do two to six products differ by label amounts and price per day?
- What upper limit does a country set for an ingredient, and in which forms?

| | |
|---|---|
| Endpoint | `https://verateca.com/mcp` |
| Transport | Streamable HTTP |
| Authentication | none — no account, no API key |
| Access | read-only |
| Official MCP Registry | [`com.verateca/verateca`](https://registry.modelcontextprotocol.io/v0.1/servers?search=com.verateca) |
| Website | [verateca.com](https://verateca.com) |

This repository holds the documentation and registry metadata. The server itself runs at verateca.com.

## Connect

Any client that supports remote MCP servers: add `https://verateca.com/mcp`, no authentication.

**Claude** (claude.ai, Desktop, mobile): Settings → Connectors → Add custom connector → name `Verateca`, URL `https://verateca.com/mcp`.

**Claude Code**

```bash
claude mcp add --transport http verateca https://verateca.com/mcp
```

**ChatGPT** (developer mode): create a connector with the URL `https://verateca.com/mcp`, authentication: none.

**Cursor** — `~/.cursor/mcp.json`

```json
{
  "mcpServers": {
    "verateca": { "url": "https://verateca.com/mcp" }
  }
}
```

**VS Code** — `.vscode/mcp.json`

```json
{
  "servers": {
    "verateca": { "type": "http", "url": "https://verateca.com/mcp" }
  }
}
```

**Gemini CLI** — install as an extension

```bash
gemini extensions install https://github.com/Verateca/verateca-mcp
```

**Clients that only run local (stdio) servers**

```json
{
  "mcpServers": {
    "verateca": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "https://verateca.com/mcp"]
    }
  }
}
```

## Tools

| Tool | What it does |
|---|---|
| `search_products` | Finds products by name, brand, ingredient or barcode (UPC/EAN). Returns up to 10 matches with IDs, page addresses and recent published prices. Results are ordered by match, never by payment. |
| `get_product` | One product: label composition, applicable reference limits, recent published prices and recorded dates. |
| `get_ingredient` | One substance by name, form or synonym: the applicable limit, other countries' limits with scope, source and check date, and known forms. |
| `check_stack` | Adds known daily amounts from up to 12 products or ingredient amounts and compares the totals with published adult upper limits. |
| `compare_products` | Compares 2 to 6 products by daily amounts, price per day and applicable limits. |
| `get_selection_link` | Returns the address of the order page for one of Verateca's paid services, with the price the site shows. Takes no payment and creates no order. |

Every tool is marked `readOnlyHint: true`. Each answer carries its sources and the dates the data was checked.

## Ask your assistant

- *I take a vitamin D3 2,000 IU softgel and a daily multivitamin. How much vitamin D is that per day, compared with the adult upper limit?*
- *Compare these two magnesium glycinate products by price per day.*
- *What is the upper limit for zinc in the US, and what do other countries set?*
- *What's on the label of this fish oil, and how much EPA and DHA is in one serving?*

## Try it from the command line

```bash
curl -s https://verateca.com/mcp \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json, text/event-stream' \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"get_ingredient","arguments":{"name":"Vitamin D"}}}'
```

## Coverage

- **Products, labels and shop prices:** United States. More markets will be added as they open on the site.
- **Upper limits:** the applicable US reference value, plus other countries' published limits where recorded, each with its type (law, guideline or reference value), scope, source and check date.
- **Prices:** published shop prices, shown per day of use.

## Scope

Verateca is reference information for adults. It sells no supplements.

It does not assess interactions between supplements and medicines, does not diagnose, and does not advise on starting, stopping or replacing a treatment. For those questions a pharmacist or the prescribing clinician is the right source. The tools take only product names, ingredients and amounts. They do not need a person's medicines, diagnoses or other health details.

## Links

- Website: <https://verateca.com>
- For AI assistants: <https://verateca.com/ai>
- Privacy: <https://verateca.com/privacy>
- Terms: <https://verateca.com/terms>
- Contact: info@verateca.com
