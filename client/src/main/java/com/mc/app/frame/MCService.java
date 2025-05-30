package com.mc.app.frame;

import com.mc.app.dto.AccomSuggestion;
import com.mc.app.dto.TravelInsight;

import java.util.List;

public interface MCService<V,K> {
    void add(V v) throws Exception;
    void mod(V v) throws Exception;
    void del(K k) throws Exception;
    V get(K k) throws Exception;
    List<V> get() throws Exception;
}
