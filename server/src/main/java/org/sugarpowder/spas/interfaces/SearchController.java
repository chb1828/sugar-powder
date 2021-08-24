package org.sugarpowder.spas.interfaces;

import org.springframework.web.bind.annotation.*;
import org.sugarpowder.spas.application.SearchService;
import org.sugarpowder.spas.domain.dayday.DDay;
import org.sugarpowder.spas.domain.dayday.DDaySearch;

import java.util.List;

@RestController
@RequestMapping("/api/search")
public class SearchController {

    private final SearchService searchService;

    public SearchController(SearchService searchService) {
        this.searchService = searchService;
    }

    @GetMapping("/month")
    public List<DDay> searchByMonth(@RequestHeader("Authorization") String userToken, @RequestParam Integer month,
                                    @RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "10") int size) {
        return searchService.searchDdayByMonth(userToken, month, page, size);
    }

    @GetMapping("/today")
    public List<DDay> searchByToday(@RequestHeader("Authorization") String userToken) {
        return searchService.getTodaysPopularDday(userToken);
    }

    @GetMapping
    public List<DDaySearch> searchByQuery(@RequestHeader("Authorization") String userToken, @RequestParam String query,
                                          @RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "10") int size) {
        return searchService.searchDdayByQuery(userToken, query, page, size);
    }

    @GetMapping("/dday/popular")
    public List<DDay> searchPopularDday(@RequestHeader("Authorization") String userToken) {
        return searchService.getPopularDday(userToken);
    }

    @GetMapping("/tag/popular")
    public List<String> searchPopularTag(@RequestHeader("Authorization") String userToken) {
        return searchService.getPopularTag();
    }
}
