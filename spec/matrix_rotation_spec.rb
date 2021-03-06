require_relative "../lib/matrix_rotation"

RSpec.describe "solution" do
  it "prints the matrix if r=0" do
    matrix = [[1, 2], [3, 4]]
    r = 0

    expect { matrixRotation(matrix, r) }.to output("1 2\n3 4\n").to_stdout
  end

  it "rotates a single layer matrix" do
    matrix = [[1, 2], [3, 4]]
    r = 1

    expect { matrixRotation(matrix, r) }.to output("2 4\n1 3\n").to_stdout
  end

  it "rotates a double layer matrix" do
    matrix = [[1, 2, 3, 4, 5], [6, 7, 8, 9, 10], [11, 12, 13, 14, 15], [16, 17, 18, 19, 20]]
    r = 2

    expect { matrixRotation(matrix, r) }.to output("3 4 5 10 15\n2 9 14 13 20\n1 8 7 12 19\n6 11 16 17 18\n").to_stdout
  end
end

RSpec.describe MatrixRotation do
  describe ".flatten" do
    it "creates a double array where each 'layer' of a matrix is laid out counter-clockwise" do
      matrix = [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16]]

      expect(MatrixRotation.flatten(matrix)).to eq([[1, 2, 3, 4, 8, 12, 16, 15, 14, 13, 9, 5], [6, 7, 11, 10]])
    end

    it "handles a single-layer matrix" do
      matrix = [[1, 2], [3, 4]]

      expect(MatrixRotation.flatten(matrix)).to eq([[1, 2, 4, 3]])
    end

    it "handles a matrix with an odd number of rows" do
      matrix = [[1, 2, 3, 4], [7, 8, 9, 10], [13, 14, 15, 16], [19, 20, 21, 22], [25, 26, 27, 28]]

      expect(MatrixRotation.flatten(matrix)).to eq([[1, 2, 3, 4, 10, 16, 22, 28, 27, 26, 25, 19, 13, 7], [8, 9, 15, 21, 20, 14]])
    end

    it "handles a matrix with an odd number of columns" do
      matrix = [[1, 2, 3, 4, 5], [6, 7, 8, 9, 10], [11, 12, 13, 14, 15], [16, 17, 18, 19, 20]]

      expect(MatrixRotation.flatten(matrix)).to eq([[1, 2, 3, 4, 5, 10, 15, 20, 19, 18, 17, 16, 11, 6], [7, 8, 9, 14, 13, 12]])
    end
  end

  describe ".rotate" do
    it "rotates each layer in a flattened matrix" do
      flat_matrix = [[1, 2, 4, 3]]

      expect(subject.rotate(flat_matrix)).to eq([[2, 4, 3, 1]])
    end
  end

  describe ".unflatten" do
    it "converts a flat_matrix with a single layer to a matrix" do
      flat_matrix = [[2, 4, 3, 1]]

      expect(subject.unflatten(flat_matrix, 2, 2)).to eq([[2, 4], [1, 3]])
    end

    it "converts a flat_matrix with two layers to a matrix" do
      flat_matrix = [[1, 2, 3, 4, 8, 12, 16, 15, 14, 13, 9, 5], [6, 7, 11, 10]]

      expect(subject.unflatten(flat_matrix, 4, 4)).to eq([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16]])
    end

    it "handles a matrix with an odd number of rows" do
      flat_matrix = [[1, 2, 3, 4, 10, 16, 22, 28, 27, 26, 25, 19, 13, 7], [8, 9, 15, 21, 20, 14]]

      expect(MatrixRotation.unflatten(flat_matrix, 4, 5)).to eq([[1, 2, 3, 4], [7, 8, 9, 10], [13, 14, 15, 16], [19, 20, 21, 22], [25, 26, 27, 28]])
    end

    it "handles a matrix with an odd number of columns" do
      flat_matrix = [[1, 2, 3, 4, 5, 10, 15, 20, 19, 18, 17, 16, 11, 6], [7, 8, 9, 14, 13, 12]]

      expect(MatrixRotation.unflatten(flat_matrix, 5, 4)).to eq([[1, 2, 3, 4, 5], [6, 7, 8, 9, 10], [11, 12, 13, 14, 15], [16, 17, 18, 19, 20]])
    end
  end

  describe ".to_string" do
    it "converts a matrix to a string" do
      matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10, 11, 12]]

      expect(MatrixRotation.to_string(matrix)).to eq("1 2 3\n4 5 6\n7 8 9\n10 11 12")
    end
  end
end
