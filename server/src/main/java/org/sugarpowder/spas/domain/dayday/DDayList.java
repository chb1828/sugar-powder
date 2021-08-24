package org.sugarpowder.spas.domain.dayday;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.sugarpowder.spas.domain.shared.dto.ApiResult;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DDayList extends ApiResult {
    private List<DDay> dDayList;
    private PageRequest page;
}
