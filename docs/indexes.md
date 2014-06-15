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
1. Check if doc has any fields that are indexed
1. If it does, update index then save doc

### Updating index on delete
1. Check if doc has any fields that are indexed
1. If it does, update index then delete doc

### Indexing nested fields
If we treat indexed fields as paths (i.e. `address.city`) then we should be able to easily cater for nested fields using the same structure that we are using now.

In the cast of `address.city`, on save/del we should check to see if that field exists (`val['address']['city']`) and if it does, then update the index.
