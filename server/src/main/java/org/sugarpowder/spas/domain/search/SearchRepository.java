package org.sugarpowder.spas.domain.search;

import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.annotations.Query;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SearchRepository extends ElasticsearchRepository<SearchVO, Long> {
    @Query("{\n" +
            "        \"bool\":{\n" +
            "                \"must\":{\n" +
            "                        \"multi_match\":{\n" +
            "                                \"query\":\"?1\",\n" +
            "                                \"fields\":[\"title^3\", \"tags\"],\n" +
            "                                \"type\":\"best_fields\"\n" +
            "                        }\n" +
            "                },\n" +
            "                \"filter\":{\n" +
            "                        \"range\":{\n" +
            "                                \"date\":{\n" +
            "                                        \"gte\": ?0\n" +
            "                                }\n" +
            "                        }\n" +
            "                }\n" +
            "        }\n" +
            "}")
    List<SearchVO> findBy(Long time, String query, Pageable pageable);
}
