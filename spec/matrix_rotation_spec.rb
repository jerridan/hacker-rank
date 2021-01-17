require_relative "../lib/matrix_rotation"

RSpec.describe MatrixRotation do
  xdescribe ".matrixRotation" do
    it "prints the matrix if r=0" do
      matrix = [[1, 2], [3, 4]]
      r = 0

      expect { subject.matrixRotation(matrix, r) }.to output("1 2\n3 4\n").to_stdout
    end

    it "rotates a single layer matrix" do
      matrix = [[1, 2], [3, 4]]
      r = 1

      expect { subject.matrixRotation(matrix, r) }.to output("2 4\n1 3\n").to_stdout
    end
  end

  describe ".flatten" do
    it "creates a double array where each 'layer' of a matrix is layed out counter-clockwise" do
      matrix = [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16]]

      expect(MatrixRotation.flatten(matrix)).to eq([[1, 2, 3, 4, 8, 12, 16, 15, 14, 13, 9, 5], [6, 7, 11, 10]])
    end

    it "handles a single-layer matrix" do
      matrix = [[1, 2], [3, 4]]

      expect(MatrixRotation.flatten(matrix)).to eq([[1, 2, 4, 3]])
    end

    it "handles a matrix with an odd number of rows" do
      matrix = [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]]

      expect(MatrixRotation.flatten(matrix)).to eq([[1, 2, 3, 4, 8, 12, 11, 10, 9, 5], [6, 7]])
    end

    it "handles a matrix with an odd number of columns" do
      matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10, 11, 12]]

      expect(MatrixRotation.flatten(matrix)).to eq([[1, 2, 3, 6, 9, 12, 11, 10, 7, 4], [5, 8]])
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
  end
end
