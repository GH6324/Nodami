package queueTraffics

import (
	"sync"
)

type Queue[T any] struct {
	list  []T
	mutex sync.Mutex
	equal func(a, b T) bool
	merge func(dst, src T) T
}

func NewQueue[T any](equal func(a, b T) bool, merge func(dst, src T) T) *Queue[T] {
	return &Queue[T]{
		list:  make([]T, 0),
		equal: equal,
		merge: merge,
	}
}

func (q *Queue[T]) Push(data T) {
	q.mutex.Lock()
	defer q.mutex.Unlock()

	for i, item := range q.list {
		if q.equal(item, data) {
			q.list[i] = q.merge(item, data)
			return
		}
	}
	q.list = append(q.list, data)
}

func (q *Queue[T]) Pop(n int) []T {
	q.mutex.Lock()
	defer q.mutex.Unlock()

	if len(q.list) == 0 {
		return []T{}
	}

	if n > len(q.list) {
		n = len(q.list)
	}

	result := q.list[:n]
	q.list = q.list[n:]

	return result
}

func (q *Queue[T]) Sum() int {
	q.mutex.Lock()
	defer q.mutex.Unlock()
	return len(q.list)
}
