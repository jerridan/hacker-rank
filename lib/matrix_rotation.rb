# Function definition - do not change
def matrixRotation(matrix, r)
  n_rows = matrix.length
  n_cols = matrix.first.length

  flat_matrix = MatrixRotation.flatten(matrix)
  r.times { MatrixRotation.rotate(flat_matrix) }
  matrix = MatrixRotation.unflatten(flat_matrix, n_cols, n_rows)

  puts MatrixRotation.to_string(matrix)
end

module MatrixRotation
  extend self

  def flatten(matrix)
    layers = []

    while matrix.any? && matrix.first != []
      top_row = matrix.shift
      bottom_row = matrix.pop&.reverse || []
      right_column = matrix.map { |row| row.pop }
      left_column = matrix.map { |row| row.shift }.reverse

      layer = top_row.concat(right_column).concat(bottom_row).concat(left_column)
      layers.push(layer)
    end

    layers
  end

  def rotate(flat_matrix)
    flat_matrix.each do |layer|
      first_element = layer.shift
      layer.push(first_element)
    end
  end

  def unflatten(flat_matrix, n_cols, n_rows)
    if (flat_matrix.length > 1)
      matrix = unflatten(flat_matrix[1..flat_matrix.length - 1], n_cols - 2, n_rows - 2)
    else
      matrix = prepare_empty_matrix(n_cols, n_rows)
    end

    layer = flat_matrix.first
    if (n_rows > 2)
      right_inner_col_from_layer(layer, n_cols, n_rows).each_with_index { |el, index| matrix[index].append el }
      left_inner_col_from_layer(layer, n_rows).each_with_index { |el, index| matrix[index].prepend el }
    end
    matrix.prepend top_row_from_layer(layer, n_cols)
    matrix.append bottom_row_from_layer(layer, n_cols, n_rows)

    matrix
  end

  def to_string(matrix)
    matrix.map { |row| row.join(" ") }.join("\n")
  end

  private

  def prepare_empty_matrix(n_cols, n_rows)
    matrix = []
    if (n_cols == 2)
      (n_rows - 2).times { matrix.append([]) }
    end

    matrix
  end

  def right_inner_col_from_layer(layer, n_cols, n_rows)
    layer[n_cols, n_rows - 2]
  end

  def left_inner_col_from_layer(layer, n_rows)
    layer[layer.length - n_rows + 2, n_rows - 2].reverse
  end

  def top_row_from_layer(layer, n_cols)
    layer[0, n_cols]
  end

  def bottom_row_from_layer(layer, n_cols, n_rows)
    layer[n_cols + n_rows - 2, n_cols].reverse
  end
end
