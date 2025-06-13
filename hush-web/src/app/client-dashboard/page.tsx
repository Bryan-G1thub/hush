// src/app/dashboard/page.tsx
'use client';

import { useState, useEffect } from 'react';
import { auth, db } from '../../../services/fireabse';
import { useRouter } from 'next/navigation';
import { collection, query, where, getDocs, addDoc, Timestamp } from 'firebase/firestore';
import { signOut } from 'firebase/auth';

interface Task {
  id: string;
  test: string;
  status: 'LIVE';
  createdAt: string;
}

export default function Dashboard() {
  const [tasks, setTasks] = useState<Task[]>([]);
  const [newTask, setNewTask] = useState({
    test: ''
  });
  const router = useRouter();

  useEffect(() => {
    const checkAuth = async () => {
      const user = auth.currentUser;
      if (!user) {
        router.push('/auth');
        return;
      }
      fetchTasks();
    };
    checkAuth();
  }, []);

  const fetchTasks = async () => {
    const user = auth.currentUser;
    if (!user) return;

    const tasksQuery = query(
      collection(db, 'tasks'),
      where('clientId', '==', user.uid)
    );

    const querySnapshot = await getDocs(tasksQuery);
    const tasksList = querySnapshot.docs.map(doc => ({
      id: doc.id,
      ...doc.data()
    })) as Task[];

    setTasks(tasksList);
  };

  const handleCreateTask = async (e: React.FormEvent) => {
    e.preventDefault();
    const user = auth.currentUser;
    if (!user) return;

    try {
      await addDoc(collection(db, 'tasks'), {
        test: newTask.test,
        clientId: user.uid,
        status: 'LIVE',
        createdAt: Timestamp.now(),
      });
      setNewTask({ test: '' });
      fetchTasks();
    } catch (error) {
      console.error('Error creating task:', error);
    }
  };

  const handleSignOut = async () => {
    try {
      await signOut(auth);
      router.push('/');
    } catch (error) {
      console.error('Error signing out:', error);
    }
  };

  return (
    <div className="min-h-screen bg-black text-white">
      {/* Header */}
      <header className="fixed w-full bg-black/80 backdrop-blur-sm border-b border-white/10">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between items-center h-16">
            <div className="flex items-center">
              <span className="text-2xl font-bold bg-gradient-to-r from-white to-white/80 bg-clip-text text-transparent">
                HUSH
              </span>
            </div>
            <button
              onClick={handleSignOut}
              className="text-white/80 hover:text-white transition-colors"
            >
              Sign Out
            </button>
          </div>
        </div>
      </header>

      <main className="pt-20 pb-12 px-4 sm:px-6 lg:px-8">
        <div className="max-w-7xl mx-auto">
          {/* Create Task Form */}
          <div className="mb-12">
            <h2 className="text-2xl font-bold mb-6">Create New Task</h2>
            <form onSubmit={handleCreateTask} className="space-y-4">
              <div>
                <label className="block text-sm font-medium mb-2">Test</label>
                <input
                  type="text"
                  value={newTask.test}
                  onChange={(e) => setNewTask({ test: e.target.value })}
                  className="w-full px-3 py-2 bg-black/50 border border-white/10 rounded-md focus:outline-none focus:ring-2 focus:ring-white/20"
                  required
                />
              </div>
              <button
                type="submit"
                className="bg-white text-black px-6 py-2 rounded-full font-medium hover:bg-white/90 transition-colors"
              >
                Create Task
              </button>
            </form>
          </div>

          {/* Tasks List */}
          <div>
            <h2 className="text-2xl font-bold mb-6">Your Tasks</h2>
            <div className="grid gap-6">
              {tasks.map((task) => (
                <div
                  key={task.id}
                  className="p-6 bg-black/50 border border-white/10 rounded-lg"
                >
                  <div className="flex justify-between items-start">
                    <div>
                      <p className="text-white/70 mb-4">Test: {task.test}</p>
                      <div className="flex gap-4 text-sm text-white/60">
                        <span>Status: {task.status}</span>
                      </div>
                    </div>
                    <span className="px-3 py-1 rounded-full text-sm bg-green-500/20 text-green-400">
                      {task.status}
                    </span>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>
      </main>
    </div>
  );
}