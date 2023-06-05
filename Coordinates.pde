class Coordinates{
    PVector point;
    float angle;
    Coordinates(PVector location, float theta) {point = location.copy(); angle = theta;}
}

void mergeSort(Coordinates[] arr, int first, int last){
    if (first >= last) return;
    
    int middle = (first + last) / 2;
    mergeSort(arr, first, middle);
    mergeSort(arr, middle+1, last);
    
    merge(arr, first, middle, middle+1, last);
}

void merge(Coordinates[] arr, int leftFirst, int leftLast, int rightFirst, int rightLast){
    Coordinates[] temp = new Coordinates[arr.length];
    
    int saveFirst = leftFirst;
    int index = leftFirst;
    
    while (leftFirst <= leftLast && rightFirst <= rightLast)
        if (arr[leftFirst].angle < arr[rightFirst].angle) temp[index++] = arr[leftFirst++];
        else temp[index++] = arr[rightFirst++];
    
    while (leftFirst <= leftLast)   temp[index++] = arr[leftFirst++];
    while (rightFirst <= rightLast) temp[index++] = arr[rightFirst++];
    
    for (index = saveFirst; index <= rightLast; index++) arr[index] = temp[index];
} 
    
    
