Query for single menu item example

Query:
```
  query ExampleQuery($id: Int!) {
    menuItem(id: $id) {
      name,
      category,
      price
    }
  }
```

Variable:

```
  {
    "id": 2
  }
```