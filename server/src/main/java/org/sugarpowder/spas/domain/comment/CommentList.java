package org.sugarpowder.spas.domain.comment;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.sugarpowder.spas.domain.shared.dto.ApiResult;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommentList extends ApiResult {
    private List<Comment> commentList;
    private PageRequest page;
    private long totalCount;
}
