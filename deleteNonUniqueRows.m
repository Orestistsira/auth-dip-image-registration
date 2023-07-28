function modifiedArray = deleteNonUniqueRows(inputArray)
    %   Deletes rows from the input array that have non-unique values in the respective columns.
    %   The function checks each column independently and retains rows where values are unique.
    %
    %   Input:
    %   - inputArray: an Mx2 array with values to be processed.
    %
    %   Output:
    %   - modifiedArray: the modified array with non-unique rows removed.

    [~, idx1, ~] = unique(inputArray(:, 1), 'stable');
    [~, idx2, ~] = unique(inputArray(:, 2), 'stable');
    
    nonUniqueRows1 = setdiff(1:size(inputArray, 1), idx1);
    nonUniqueRows2 = setdiff(1:size(inputArray, 1), idx2);
    duplicateRows = union(nonUniqueRows1, nonUniqueRows2);
    
    modifiedArray = inputArray;
    modifiedArray(duplicateRows, :) = [];
end


