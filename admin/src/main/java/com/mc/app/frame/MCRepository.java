package com.mc.app.frame;

import java.util.List;

public interface MCRepository<V,K> {
    void insert(V v) throws Exception;
    void update(V v) throws Exception;
    void delete(K k) throws Exception;
    V selectOne(K k) throws Exception;
    List<V> select() throws Exception;
}
