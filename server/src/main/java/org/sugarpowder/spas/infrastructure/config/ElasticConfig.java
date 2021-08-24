package org.sugarpowder.spas.infrastructure.config;

import org.elasticsearch.client.RestHighLevelClient;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.elasticsearch.client.ClientConfiguration;
import org.springframework.data.elasticsearch.client.RestClients;
import org.springframework.data.elasticsearch.config.AbstractElasticsearchConfiguration;

@Configuration
public class ElasticConfig
        extends AbstractElasticsearchConfiguration {
    @Override
    @Bean
    public RestHighLevelClient elasticsearchClient() {
        final ClientConfiguration configuration = ClientConfiguration.builder()
                .connectedTo("search-sugar-fx4m5t6em7ngqmmho3s3meahyq.ap-northeast-2.es.amazonaws.com:443")
                .usingSsl()
                .build();

        return RestClients.create(configuration).rest();
    }


//    @Bean
//    public RestHighLevelClient restHighLevelClient() {
//        RestHighLevelClient highLevelClient = new RestHighLevelClient(
//                RestClient.builder(new HttpHost(""))
//        )
//    }
}