# RedJ(s)ON - Indexing
An experiment in Redis JSONification

----

## Overview
RedJ(s)ON indexes are created by scanning through every key looking for the target field (after the required MsgPack unpack dance).

If a key is found to have the target field, it's value is inserted(`ZADD`) into the index's sorted list with the key being re-used as the value in the new index sorted list.

```JSON
# Doc with key "jim@gmail.com"
{
  "name":"Jim Smith",
  "age":35
}
```
The above "doc" will result in the index entry `Value: jim@gmail.com, Score: 35`.

## Querying
Querying is carried out by executing `ZRANGEBYSCORE` with the target scores.

## Notes

### Updating index on save
1. Check if doc to be written has required field
1. If it does, wrap index update + doc save in transaction (`MULTI`)
1. Execute

### Updating index on delete
1. Check if key exists in any index
1. If it does, wrap index update + doc delete in transaction (`MULTI`)
1. Execute
